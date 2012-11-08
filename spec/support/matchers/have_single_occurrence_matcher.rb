RSpec::Matchers.define :have_a_single_occurence_of do |expected|
  match do |actual|
    actual.scan(expected).size == 1
  end

  description do
    "have a single occurence of #{expected.inspect}"
  end
end
