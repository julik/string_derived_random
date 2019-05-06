require 'digest'

module StringDerivedRandom
  require_relative "string_derived_random/version"

  class Error < StandardError; end

  # For quick bucketing of "process one in N" objects
  def is_one_in?(n, string_seed:)
    raise ArgumentError if n < 1
    new(string_seed).rand(1..n) == 1
  end

  # The objective here is getting a stable random
  # number based on a given string. We use the string to
  # generate a big Integer that can be used to seed a
  # Random object at creation. This allows us to
  # experiment by, say, applying something to
  #'every 100th of some class of objects having this identifier',
  # with the result being exactly the same for that identifier,
  # every time.
  #
  # @param string_seed[#to_s] An object that can be converted into a String
  # @return [Random] A seeded Random object
  def new(string_seed)
    # Compute a digest that gives us a good
    # distribution of values. Doesn't matter which
    # digest gets used since it is the distribution
    # that matters, as well as consistency and a broader
    # range of possible values
    digest_bytes = Digest::SHA256.digest(string_seed.to_s)

    # We get 256 bits of information from the digest.
    # The Mersenne twister can be seeded with values
    # in a certain range, after which the seed rolls over.
    # For the gory details read https://stackoverflow.com/a/20082583/153886
    # but basically the range is this:
    #
    # 2 ** ( 624 * 32 )
    #
    # which is actually 19968 bits of available values, quite a bit more
    # than what the SHA256 gives us - which is only 256 bits.
    # So for our purposes we can just use those values and relax, as there
    # is no requirement for this seed to be cryptographically-secure.
    # https://stackoverflow.com/a/17556861/153886 for the bytes -> bigint part
    seed_int = digest_bytes.bytes.inject {|a, b| (a << 8) + b }
    Random.new(seed_int)
  end

  extend self
end
