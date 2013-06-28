Gem::Specification.new do |s|
  s.name        = 'resellerclub'
  s.version     = '1.0.0'
  s.date        = '2012-11-21'
  s.summary     = "A gem that implements partially ResellerClub API"
  s.description = "A gem that implements the sections Customer, Reseller, Contact and Domain from ResellerClub"
  s.authors     = ["Arun Kumar"]
  s.email       = 'arunkumar@kreatio.com'
  s.add_dependency("typhoeus", ">= 0.3.3")
  s.add_dependency("json", ">= 0")
  s.add_dependency("rspec", ">= 2.11.0")
  s.add_dependency("rspec-expectations", ">= 2.11.3")
  s.files       = ["lib/resellerclub.rb", "lib/mixin.rb", "spec/basic_spec.rb", "lib/models/contact.rb", "lib/models/customer.rb", "lib/models/reseller.rb", "lib/models/domain.rb", "lib/models/order.rb"]
end
