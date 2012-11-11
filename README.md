# TinyRails

Scaffold for tiny Rails apps based on José Valim's Rails Lightweight Stack
[code](https://gist.github.com/1942658)

## Installation

Install it using:

    $ gem install tiny-rails

## Usage

```terminal
$ tiny-rails new tiny-app
      create
      create  .gitignore
      create  Gemfile
      create  boot.rb
      create  tiny_rails_controller.rb
      create  index.html.erb
      create  server
      create  config.ru
       chmod  server
```

This will give you a pretty basic application that you can run with `rackup`
or you prefferend server. It even supports code reloading for the generated
controller!


## Addons

You can provide the `-a` parameter when creating new apllications to enable a
list of "addons" on the generated app. For example:

```terminal
$ tiny-rails new tiny-app -a activerecord
         ...
       apply  /path/to/tiny-rails/gem/addons/activerecord.rb
     gemfile    activerecord (~> 3.2)
     gemfile    sqlite3
      create    models.rb
      insert    tiny_rails_controller.rb
      insert    boot.rb
      create    migrate
       chmod    migrate
      append    .gitignore
```

Or you can run `tiny-rails add [list of addons]` from a generated application
folder.

Here's a list of the addons bundled with the gem:

* [activerecord](https://github.com/fgrehm/tiny-rails/blob/master/addons/activerecord.rb)


### Building your own addon

The API for writing addon scripts are based on Rails'
[application templates](http://edgeguides.rubyonrails.org/rails_application_templates.html)
(with a smaller API), please have a look at the [bundled addons](https://github.com/fgrehm/tiny-rails/blob/master/addons/),
[`TinyRails::Actions`](https://github.com/fgrehm/tiny-rails/blob/master/lib/tiny-rails/actions.rb)
and [`Thor::Actions`](http://rdoc.info/github/wycats/thor/master/Thor/Actions.html)
modules to find out whats supported.

As with Rails' application templates, you can use remote addon scripts, just pass
in the URL as an argument to `tiny-rails new` or `tiny-rails add`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
