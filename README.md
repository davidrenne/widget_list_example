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

Open `/` for the Sequel list and `/ransack` for the Active Record list. Search SKU `1001`, use the advanced filter arrow, or export CSV. The Gemfile points to the sibling gem checkout, so restart the Rails server after editing the gem.

The upgrade replaced Rails 3 callbacks, legacy asset middleware, and obsolete Ruby URL APIs. It also adds Sprockets/jQuery assets, SQLite seed data, a Ransack allowlist, GET and POST list routes, and integration tests. This example is retained as a historical migration reference; the separate Rails 8 caller is the concise starting point.
