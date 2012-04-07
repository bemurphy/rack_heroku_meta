require "rack/heroku_meta/version"

module Rack
  class HerokuMeta
    DEFAULT_ROUTE = "/heroku_meta"

    def initialize(app, options = {})
      @app = app
      @route = options.fetch(:route, DEFAULT_ROUTE)
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      if env["PATH_INFO"] == @route
        env["REQUEST_METHOD"] == "GET" ? serve_meta : not_found
      else
        @app.call(env)
      end
    end

    private

    def not_found
      [404, { "Content-Type" => "plain/text" }, ["Not Found"]]
    end

    def meta
      ps = ENV["PS"]
      commit_hash = ENV["COMMIT_HASH"]
      %Q({"ps":"#{ps}","commit_hash":"#{commit_hash}"})
    end

    def serve_meta
      [200, { "Content-Type" => "application/json" }, [meta]]
    end
  end
end
