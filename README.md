# r_dockerize

 `r_dockerize` is a tool for generating ruby and rails Dockerfile and docker-compose.yml

## Requirements

* Ruby 2.6.0+

## Installation

```bash
bundle install r_dockerize
```
...or add the following to your `Gemfile` and run `bundle install`:
```
gem 'r_dockerize', require: false
```

## Usage

This gem provides a command-line interface which can be run like so:

1. Run `r_dockerize <command> [options]` if gem installed in system
2. Run `bundle exec r_dockerize <command> [options]` if gem installed in your Gemfile

### Available commands
1. `r_dockerize docker [options]` - for create Dockerfile
```bash
Usage:
   rdockerize docker [options]

Options:
    -s, --show                       # Show assembled dockerfile
    -u, --user                       # Use saved user's template
    -j, --javascript=JAVASCRIPT      # Choose JavaScript approach [options: npm, yarn]
    -r, --ruby=RUBY_VERSION          # Choose version of ruby
    -d, --database=DATABASE          # Choose database [options: sqlite]
    --standard                       # Standard template
    -h, --help                       # Print help for command
```
2. `r_dockerize dco ` / `compose`/ `docker-compose [options]` - for create docker-compose.yml
```bash
Usage:
  rdockerize dco [options]
  rdockerize compose [options]
  rdockerize docker-compose [options]

Options:
    -s, --show                       # Show assembled docker-compose file
    -u, --user                       # Use saved user's template
    -d, --database=DATABASE          # Choose database [options: sqlite]
    -b, --subservice=SUBSERVICE      # Choose subservice [options: redis rabbitmq sidekiq]
    -h, --help                       # Print help for command

```
3. `r_dockerize dockerize [options]` - for create both (Dockerfie and docker-compose.yml)
```bash
Usage:
  rdockerize dockerize [options]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `gem install r_dockerize`. To release a new version, update the version number in `version.rb`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Keallar/r_dockerize.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
