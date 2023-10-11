> After loading the framework and any gems in your application, Rails turns to loading initializers. An initializer is any Ruby file stored under config/initializers in your Rails application.
The files in config/initializers are _sorted_ and _loaded_ _one by one_ as part of the load_config_initializers initializer.
If an initializer has code that relies on code in another initializer, you can combine them into a single initializer instead. This makes the dependencies more explicit, and can help surface new concepts within your application. Rails also supports _numbering of initializer file names_, but this can lead to file name churn.

Ordered Initiliazers simply allows you to choose the order in which you want your initializers to be loaded, independently of their name.

# Installation

Add this line to the top of your Rails application's Gemfile:

```ruby
gem 'ordered_initializers'
```

And then install the gem:

```shell
$ bundle install
```

You can set your initializers order in the `config/initializers.yml` file. Because there is no possibility to prevent Rails from loading files in `config/initializers`, you need to store your initializers files in the `config/ordered_initializers` folder.

Ordered Initiliazers provides a rake task that will automatically moves the files from `config/initializers` to`config/ordered_initializers`, generates the `config/initializers.yml` file and leaves a small reminder in `config/initializers`.

```shell
$ rake ordered_initializers:install
```

You can reorder the initializers path as you see fit.

You can still add files to `config/initializers`. They will be loaded alphabetically after the ones in `config/ordered_initializers`.

Running `rake ordered_initializers:install` again will simply append the new files from `config/initializers` at the end of `config/initializers.yml`.
