# widget_list legacy example rebuilt on Rails 8

This repository began as a Rails 3.2 example. Its commit history retains the original controller, administration, and database samples. The current checkout is a Rails 8.1.4 SQLite rebuild that exercises the local `../widget_list` gem with Sequel 5.109.0 and Ransack 5.0.2.

For a smaller, newly generated caller app and a file-by-file setup guide, use [widget_list_example_rails8](https://github.com/davidrenne/widget_list_example_rails8). The [gem README](https://github.com/davidrenne/widget_list) has copyable instructions for adding the gem to an existing Rails app.

## Run

```sh
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails test
bin/rails server
```

Open `/` for the Sequel list and `/ransack` for the Active Record list. Search SKU `1001`, use the advanced filter arrow, or export CSV. Use the **Administration Console** link from either list page, or open `/administration`, to configure an `Item` list, preview it, and generate controller code. The console route is available only in development and test. The Gemfile points to the sibling gem checkout, so restart the Rails server after editing the gem.

The administration wizard writes draft and saved configuration to `config/widget-list-administration*.json`; these local working files are ignored by Git. The gem's [README administration section](https://github.com/davidrenne/widget_list#administration-console) shows the route, controller, view, and original screenshots. The restored wizard needs the 2.0.1 source in the sibling checkout; RubyGems 2.0.0 does not contain its Rails 8 fixes.

The upgrade replaced Rails 3 callbacks, legacy asset middleware, and obsolete Ruby URL APIs. It also adds Sprockets/jQuery assets, SQLite seed data, a Ransack allowlist, GET and POST list routes, and integration tests. This example is retained as a historical migration reference; the separate Rails 8 caller is the concise starting point.
