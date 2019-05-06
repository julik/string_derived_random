# StringDerivedRandom

Allows one to seed a Ruby `Random` object with a seed value that is derived from a given string. This
can be useful for doing "one-in-N" selection for large corpi of identifiers. For example:

```ruby
rng = StringDerivedRandom.new(document.id.to_s)
rng.rand # => the result is always going to be the same
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'string_derived_random'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install string_derived_random

## Usage

In your code, use a string identifier (for example a filesystem path, or a user ID) to create a generator,
and then use the generator to emit random values. The generator is a Ruby `Random` object.

```ruby
if StringDerivedRandom.new(file_path).rand(1..200) == 1
  apply_processing # will apply to one in 200 file paths
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julik/string_derived_random.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
