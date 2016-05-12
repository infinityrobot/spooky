# :ghost: Spooky

:gem: A super simple Ruby wrapper for the [Ghost](https://ghost.org) pubic API which provides a nice set of objects which make handling Ghost resources a breeze.

The full Ghost API documentation can be found [here](https://api.ghost.org/v0.1/docs).

## :memo: Todo

- Write specs

## Installation

To get started, add spooky to your application's Gemfile:

```ruby
gem "spooky"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spooky

## Usage

To get started, a Ghost client needs to be initialized using the subdomain of your Ghost blog and its client ID and client secret.

### Initializing a client (`Spooky::Client`)

#### Initialize manually

A client can be created by running the below with your credentials:

```ruby
Spooky::Client.new(subdomain: "subdomain", client_id: "id", client_secret: "secret")
```
#### Initialize with ENV variables

Spooky also has ENV variable support out of the box. You can set your credentials by setting the below ENV variables:

Attribute     | ENV variable         
:------------ | :--------------------
subdomain     | `GHOST_SUBDOMAIN`    
client_id     | `GHOST_CLIENT_ID`    
client_secret | `GHOST_CLIENT_SECRET`

If they above are set then all you have to do to initialize a client is run:

```ruby
Spooky::Client.new
```
### Fetching Ghost collections

There are 3 main types of Ghost collections that Spooky can fetch, `posts`, `users`, and `tags`.

Collections of `posts`, `users` or `tags` can be fetched by calling its respective collection method on an initialized Ghost client. We can also pass a hash of options as per the Ghost API to any client collection methods too. For all options that can be passed, see the [Ghost API docs](https://api.ghost.org/docs).

By default, all collection fetch methods will also fetch all of an object's associations or counts – e.g., fetching posts will also fetch and associate its tags and authors.

Say we have already initialized a Ghost client using ENV variables as:

```ruby
  @spooky = Spooky::Client.new
```
We can then access collections of various resources by calling the below methods:

Collection | Method   | Example         | Example with options          | Result
:--------- | :------- | :-------------- | :---------------------------- | :------------------------------
posts      | `#posts` | `@spooky.posts` | `@spooky.posts(limit: "all")` | Array of `Spooky::Post` objects
tags       | `#tags`  | `@spooky.tags`  | `@spooky.tags(page: 2)`       | Array of `Spooky::Tag` objects
users      | `#users` | `@spooky.users` | `@spooky.users(order: "asc")` | Array of `Spooky::User` objects

### Individual collection members

Spooky provides a number of utility methods to also fetch individual collection members based on a number of fields including a member's `id` or `slug`.

The table below summarises all of the available individual member fetch methods with the attributes available on those member objects assuming we have initialized a Ghost client as above.

Type | Spooky Object  | Fetch by ID              | Fetch by slug                | Result
:--- | :------------- | :----------------------- | :--------------------------- | :--------------------
Post | `Spooky::Post` | `@spooky.post_by_id(id)` | `@spooky.post_by_slug(slug)` | `Spooky::Post` object
Tag  | `Spooky::Tag`  | `@spooky.tag_by_id(id)`  | `@spooky.tag_by_slug(slug)`  | `Spooky::Tag` object
User | `Spooky::User` | `@spooky.user_by_id(id)` | `@spooky.user_by_slug(slug)` | `Spooky::User` object

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinityrobot/spooky. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Git commit message guidelines

We follow the GitHub git commit message guidelines:

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Remove ability to..." not "Removes ability to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally
- Consider starting the commit message with an applicable emoji as per the below

#### Git commit message emoji list

Emoji              | Code                 | Usage
:----------------: | :------------------- | :----------------------------------------------------------------
:tada:             | `:tada:`             | When adding major features / releases
:balloon:          | `:balloon:`          | When adding minor features
:wrench:           | `:wrench:`           | When adding utilities & other items that are not product features
:bulb:             | `:bulb:`             | When refactoring or improving format / structure of existing code
:shirt:            | `:shirt:`            | When removing linter warnings
:fire:             | `:fire:`             | When removing code or files
:bug:              | `:bug:`              | When fixing a bug
:racehorse:        | `:racehorse:`        | When improving performance
:art:              | `:art:`              | When adding or updating design / style elements
:white_check_mark: | `:white_check_mark:` | When adding or fixing tests
:green_heart:      | `:green_heart:`      | When fixing the CI build
:lock:             | `:lock:`             | When dealing with security items
:chart:            | `:chart:`            | When adding or updating analytics
:gem:              | `:gem:`              | When adding gems or Ruby dependencies
:baby_chick:       | `:baby_chick:`       | When adding Bower dependencies
:arrow_up:         | `:arrow_up:`         | When upgrading dependencies
:arrow_down:       | `:arrow_down:`       | When downgrading dependencies
:memo:             | `:memo:`             | When adding, editing or removing documentation

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
