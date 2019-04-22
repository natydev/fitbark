![](https://inch-ci.org/github/natydev/fitbark.svg?branch=master&amp;style=flat)
[![Build Status](https://travis-ci.org/natydev/fitbark.png?branch=master)](https://travis-ci.org/natydev/fitbark)
[![Maintainability](https://api.codeclimate.com/v1/badges/20bcd9a6380363916f5e/maintainability)](https://codeclimate.com/github/natydev/fitbark/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/20bcd9a6380363916f5e/test_coverage)](https://codeclimate.com/github/natydev/fitbark/test_coverage)
[![Gem Version](https://badge.fury.io/rb/fitbark.svg)](https://badge.fury.io/rb/fitbark)


# FitBark

A Ruby interface to the FitBark® API.

* website: [https://www.fitbark.com](https://www.fitbark.com)
* API documentation: [https://www.fitbark.com/dev/](https://www.fitbark.com/dev/)

Using this **gem** you will **benefit** from the following **advantages** over the FitBark's source API (which unfortunately does not fully follow the REST good practices):

* Consistency in the nomenclature (ex: collections named as plural, single objects as singular, standardized key params in different methods/calls).
* Items as real specific objects.
* Attribute value received according to the right type (`String`, `Integer`, `Time`, `Date` ...).
* Attibutes aliases with ruby-friendly nomenclature (ex: `*_at` for time values, `*_on` for dates, `*?` for predicates, etc.)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fitbark'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fitbark


## Usage and examples

First of all, to use this gem you need to register inside FitBark's website for a FitBark Developer Application.

Once you have the `client_id` and `client_secret` you can start to use FitBark's API.

### Authentication

First step: in Terminal open `irb` or rails `console`, then generate an **authorization uri**:

```ruby
  require 'fitbark'
  
  client_id = 'CLIENT-ID-PROVIDED-BY-FITBARK'
  client_secret = 'CLIENT-SECRET-PROVIDED-BY-FITBARK'
  redirect_uri = 'urn:ietf:wg:oauth:2.0:oob'
  
  auth = Fitbark::Auth.new(client_id: client_id, redirect_uri: redirect_uri)
  auth.authorization_uri
```
Second step: open/redirect your browser to authorization uri, a prompt for a **user login** will appear, once the login is done an **authorization code** can be fetched from success redirection (in the uri or html).

Third step: retieve **access token**:

```ruby
  authorization_code = '27e5dd1307cddc7b5d8d72264ef1...'
  
  auth = Fitbark::Auth.new(client_id: client_id, redirect_uri: redirect_uri,  
         code: authorization_code, client_secret: client_secret)
  data_token = auth.fetch_access_token!
```

#### Fitbark::Auth #fetch\_access\_token!

Returns an object kind `Fitbark::Data::Token` having this properties:

  - **token**: the access token string.
  - **type**: access token's typology.
  - **expires_at**: a time based on the expires_in attribute.
  - **scopes**: an array of scopes

### Interface

With `Fitbark::Client` we interact with API endpoints calling the specific methods.  
To use a client it must be initialized with a token:

```ruby
  client = Fitbark::Client.new(token: data_token.token)
```

logged user informations:

```ruby
  user = client.user_info
  # returns an object Fitbark::Data::UserInfo
```

user's picture:

```ruby
  client.user_picture(user_slug: user.slug)
  # returns an object Fitbark::Data::PictureInfo
```

all dogs owned by logged user:

```ruby
  client.own_dogs
  # returns an array of Fitbark::Data::DogInfo
```

all dogs having friendship with logged user:

```ruby
  client.friend_dogs
  # returns an array of Fitbark::Data::DogInfo
```

choice a dog from my owned dogs:

```ruby
  my_dog = client.own_dogs.first
  # returns an object Fitbark::Data::DogInfo
```

retrieve a dog's picture:

```ruby
  client.dog_picture(dog_slug: my_dog.slug)
  # returns an object Fitbark::Data::PictureInfo
```

retrieve daily activity series (in a selected date range):

```ruby
client.activity_series(dog_slug: my_dog.slug,  
 from: 7.days.ago, to: Date.today, resolution: :daily)
 # returns an array of Fitbark::Data::ActivityDaily
```

hourly activity series (in a selected date range):

```ruby
client.activity_series(dog_slug: my_dog.slug,  
 from: 3.days.ago, to: Date.today, resolution: :hourly)
 # returns an array of Fitbark::Data::ActivityHourly
```

total activity points (in a selected date range):

```ruby
client.activity_total(dog_slug: my_dog.slug, from: 20.days.ago, to: Date.today)
# returns an Integer
```

statistics about similar dogs:

```ruby
client.similar_dogs_stats(dog_slug: my_dog.slug)
# returns a Fitbark::Data::SimilarDogsStat object
```

time breakdown(in a selected date range):

```ruby
client.time_breakdown(dog_slug: my_dog.slug, from: 20.days.ago, to: Date.today)
# returns a Fitbark::Data::ActivityLevel object
```

For complete documentation about all client's methods and all attributes for returned data objects please read the following section.


## Documentation

If you clone this repository in your local machine, complete documentation abount all classes and modules can be make in terminal with the command **rdoc** (from project's root directory).

    $ rdoc


## Tests

Run tests with **rspec** (from project's root directory) in Terminal:

    $ bundle exec rspec



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/natydev/fitbark. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
