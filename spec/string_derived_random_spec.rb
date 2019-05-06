RSpec.describe StringDerivedRandom do
  it "has a version number" do
    expect(StringDerivedRandom::VERSION).not_to be nil
  end

  it "generates the same seed from the same string" do
    rng_jane_1 = StringDerivedRandom.new("jane")
    expect(rng_jane_1).to be_kind_of(Random)

    rng_jane_2 = StringDerivedRandom.new("jane")
    expect(rng_jane_2.seed).to eq(rng_jane_1.seed)

    rng_joe = StringDerivedRandom.new("joe")
    expect(rng_joe.seed).not_to eq(rng_jane_1.seed)
  end

  it "applies sufficient spread to strings that differ in a small way" do
    rng_1 = StringDerivedRandom.new("1")
    rng_2 = StringDerivedRandom.new("2")
    expect((rng_1.seed - rng_2.seed).abs).to be > (2**8)
  end
end
