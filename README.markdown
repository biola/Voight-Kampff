Voight-Kampff
=============
[![Build Status](https://travis-ci.org/biola/Voight-Kampff.png?branch=master)](https://travis-ci.org/biola/Voight-Kampff)

Voight-Kampff relies on a [user agent](http://en.wikipedia.org/wiki/User_agent) list for its detection. It can easily tell you if a request is coming from a crawler, spider or bot. This can be especially helpful in analytics such as page hit tracking.

Installation
------------
`gem install voight_kampff`

Configuration
-------------

A JSON file is used to match [user agent strings](http://simplyfast.info/browser) to a list of known bots.

If you'd like to use an [updated list](https://github.com/monperrus/crawler-user-agents) or make your own customizations, run `rake voight_kampff:import_user_agents`. This will download a crawler-user-agents.json file into the `./config` directory.

__Note:__ The pattern entries in the JSON file are evaluated as [regular expressions](http://en.wikipedia.org/wiki/Regular_expression).

Usage
-----
There are three ways to use Voight-Kampff

1. In your [Ruby on Rails](http://rubyonrails.org) controllers:  
   `request.bot?`

2. Through the `VoightKampff` module:  
   `VoightKampff.bot? 'your user agent string'`

3. Through a `VoightKampff::Test` instance:  
   `VoightKampff::Test.new('your user agent string').bot?`

All of the above examples accept `human?` and `bot?` methods. All of these methods will return `true` or `false`.

FAQ
---
__Q:__ __What's with the name?__  
__A:__ It's the [machine in Blade Runner](http://en.wikipedia.org/wiki/Blade_Runner#Voight-Kampff_machine) that is used to test whether someone is a human or a replicant.

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

  * bundle install
  * rake
  * rake test #code tests
  * rake spec #app tests

Automate Tests? Fear not.
------------------------
  * gem install autotest-standalone
  * autotest
  * that's it
  * wq
