Voight-Kampff
=============
[![Build Status](https://travis-ci.org/biola/Voight-Kampff.svg?branch=master)](https://travis-ci.org/biola/Voight-Kampff)
[![Code Climate](https://codeclimate.com/github/biola/Voight-Kampff/badges/gpa.svg)](https://codeclimate.com/github/biola/Voight-Kampff)
[![Gem Version](https://badge.fury.io/rb/voight_kampff.svg)](https://badge.fury.io/rb/voight_kampff)

Voight-Kampff relies on a [user agent](http://en.wikipedia.org/wiki/User_agent) list for its detection. It can easily tell you if a request is coming from a crawler, spider or bot. This can be especially helpful in analytics such as page hit tracking.

Installation
------------

`gem install voight_kampff`

If you're using Rails and want to add `ActionDispatch::Request#bot?` and `ActionDispatch::Request#human?` methods, require `voight_kampff/rails`:

```Gemfile
gem 'voight_kampff', require: 'voight_kampff/rails'
```

if you're using pure Rack, require it the following way:

```Gemfile
gem 'voight_kampff', require: 'voight_kampff/rack'
```

Configuration
-------------

A JSON file is used to match [user agent strings](http://simplyfast.info/browser) to a list of known bots.

If you'd like to use an [updated list](https://github.com/monperrus/crawler-user-agents) or make your own customizations, run `rake voight_kampff:import_user_agents`. This will download a `crawler-user-agents.json` file into the `./config` directory.

__Note:__ The pattern entries in the JSON file are evaluated as [regular expressions](http://en.wikipedia.org/wiki/Regular_expression).

Usage
-----
There are three ways to use Voight-Kampff

1. Through Rack::Request such as in your [Ruby on Rails](http://rubyonrails.org) controllers:  
   `request.bot?`

2. Through the `VoightKampff` module:  
   `VoightKampff.bot? 'your user agent string'`

3. Through a `VoightKampff::Test` instance:  
   `VoightKampff::Test.new('your user agent string').bot?`

All of the above examples accept `human?` and `bot?` methods. All of these methods will return `true` or `false`.

Upgrading to version 1.0
------------------------

Version 1.0 uses a new source for a list of bot user agent strings since the old source was no longer maintained. This new source, unfortuately, does not include as much detail. Therefore the following methods have been deprecated:
- `#browser?`
- `#checker?`
- `#downloader?`
- `#proxy?`
- `#crawler?`
- `#spam?`

In general the `#bot?` command tends to include all of these and I'm sure it's unlikely that anybody was getting this granular with their bot checking. So I see it as a small price to pay for an open and up to date bot list.

Also, the gem no longer extends `ActionDispatch::Request` instead it extends `Rack::Request` which `ActionDispatch::Request` inherits from. This allows the same functionality for Rails while opening the gem up to other rack-based projects.

Upgrading to version 2.0
------------------------

If you use Rails and `ActionDispatch::Request#bot?` and `ActionDispatch::Request#human?` methods, change your gemfile:

```diff
-gem 'voight_kampff'
+gem 'voight_kampff', require: 'voight_kampff/rails'
```

If you use Rack, change your gemfile:

```diff
-gem 'voight_kampff'
+gem 'voight_kampff', require: 'voight_kampff/rack'
```

FAQ
---
__Q:__ __What's with the name?__  
__A:__ It's the [machine in Blade Runner](https://en.wikipedia.org/wiki/Blade_Runner#Voight-Kampff_machine) that is used to test whether someone is a human or a replicant.

__Q:__ __I've found a bot that isn't being matched__  
__A:__ The list is being pulled from [github.com/monperrus/crawler-user-agents](https://github.com/monperrus/crawler-user-agents).
If you'd  like to have entries added to the list, please create a pull request with that project. Once that pull request is merged, feel free to create an issue here and I'll release a new gem version with the updated list. In the meantime you can always run `rake voight_kampff:import_user_agents` on your project to get that updated list.

__Q:__ __Why don't you use the user agent list from ______________
If you know of a better source for a list of bot user agent strings, please create an issue and let me know. I'm open to switching to a better source or supporting multiple sources. There are others out there but I like the openness of monperrus' list.

Thanks
------
Thanks to [github.com/monperrus/crawler-user-agents](https://github.com/monperrus/crawler-user-agents) for providing an open and easily updatable list of bot user agents.

Contributing
------------
PR without tests will not get merged, Make sure you write tests for api and rails app.
Feel free to ask for help, if you do not know how to write a determined test.

Running Tests?
--------------

  - `bundle install`
  - `bundle exec rspec`
