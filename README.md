Rack::HerokuMeta
================

Rack middleware for checking the process commit hash on Heroku

Why
---

On Heroku deployments, a dyno ENV has PS and COMMIT_HASH values
that are useful for viewing the state of the deploy.  The commit
hash contains the short sha1 from the most recent deploy, while
ps contains the process name of the dyno.

Sometimes when deploying to Heroku, a dyno gets "stuck" and
continues serving up the previous deploy.  This can cause
problems.  The middleware provides one way of quickly checking.

How
---

In your gemfile:

```ruby
gem "rack_heroku_meta", :require => "rack/heroku_meta"
```

In your rackup:

```ruby
use Rack::HerokuMeta # defaults to /heroku_meta
```

or with a configured route

```ruby
use Rack::HerokuMeta, :route => "/foo_bar"
```

You can then hit the route with an http client of your choice
and parse the returned JSON data.

Security
--------

The endpoint exposes information about your current Heroku deploy.
While the information is probably benign, if you are concerned,
either deploy authentication middleware to protect the route, or
simply configure the route randomly like "/meta_6960VYT6vU0mK"

Alternatives
------------

The Heroku PS API is a more detailed way to view process data
about your entire application stack.  However, if you want quick
and dirty, especially if you have minimal dynos running, this gem
can be of help.

#### Copyright

Copyright (c) (2012) Brendon Murphy. See LICENSE for details.

