require 'spec_helper'

describe "Requests using Rack::HerokuMeta" do
  let(:app) {
    Rack::Builder.new do
      use Rack::HerokuMeta
      run lambda { |env| [200, { 'Content-Type' => "text/plain" }, ["bar"]]}
    end
  }

  context "for a GET to the default /heroku_meta route" do
    let(:response) {
      Rack::MockRequest.new(app).get('/heroku_meta')
    }

    it "returns content-type of application/json" do
      response.headers["Content-Type"].should == "application/json"
    end

    it "includes ENV['PS']" do
      ENV["PS"] = "web.42"
      JSON.parse(response.body)["ps"].should == "web.42"
    end

    it "includes ENV['COMMIT_HASH']" do
      ENV["COMMIT_HASH"] = "ab123f"
      JSON.parse(response.body)["commit_hash"].should == "ab123f"
    end
  end

  context "for a POST to the default route" do
    it "is status 404" do
      response = Rack::MockRequest.new(app).post('/heroku_meta')
      response.status.should == 404
    end
  end

  context "for another route" do
    it "passes it through the app stack" do
      response = Rack::MockRequest.new(app).get('/foo')
      response.status.should == 200
      response.body.should == "bar"
    end
  end

  context "for a configured meta route" do
    let(:app) {
      Rack::Builder.new do
        use Rack::HerokuMeta, :route => "/foo_bar_321"
        run lambda { |env| [200, { 'Content-Type' => "text/plain" }, ["bar"]]}
      end
    }

    it "returns the meta info" do
      ENV["PS"] = "web.77"
      ENV["COMMIT_HASH"] = "123456"
      response = Rack::MockRequest.new(app).get('/foo_bar_321')
      meta = JSON.parse(response.body)
      meta["ps"].should == "web.77"
      meta["commit_hash"].should == "123456"
    end
  end
end
