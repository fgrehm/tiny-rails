# TinyRails

Scaffold for tiny Rails apps based on José Valim's Rails Lightweight Stack
[code](https://gist.github.com/1942658).


### DEPRECATED

I'm no longer maintaing this and if you are looking into a "lightweight Rails stack" these days you probably want to use [rails-api](https://github.com/rails-api/rails-api)


## Installation

Install it using:

    $ gem install tiny-rails


## WTF?! Why would I use this?

Although the generated application code could be used on a production server,
the idea is to try to give you a really basic application to try out new Rails
gems, create spikes and to provide an isolated small Rails environment for
reproducing bugs to support bug reports and / or to [demo](https://github.com/fgrehm/letter_opener_web#try-it-out)
your Rails engine.

You could also use this to create a single page application with Rails
features like code reloading and the asset pipeline without having to set up
a Sinatra application from the ground app.


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
or you preferred server. It even supports code reloading for the generated
controller, models and mailers!

You can also fire up a console to play around with the generated app running
`tiny-rails console`. If you want to use Pry, you can just add the `pry-rails`
gem to your Gemfile.


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
* [coffeescript](https://github.com/fgrehm/tiny-rails/blob/master/addons/coffeescript.rb)
* [jquery](https://github.com/fgrehm/tiny-rails/blob/master/addons/jquery.rb)
* [client_side_validations](https://github.com/fgrehm/tiny-rails/blob/master/addons/client_side_validations.rb)
* [email](https://github.com/fgrehm/tiny-rails/blob/master/addons/email.rb)


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
