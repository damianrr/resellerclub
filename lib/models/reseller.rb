require_relative '../mixin.rb'

class Reseller
  class << self
    BASE_URL = "https://test.httpapi.com/api/customers/"

    extend ResellerClubMethods

    [{"values" => {"lang_pref" => "en"}, "http_method" => "post","validate" => lambda {|v| true}, "url" => "signup.json"},
     {"values" => {"lang_pref" => "en"}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-details.json"},
     {"values" => {"reseller_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "details.json"},
     {"values" => {"reseller_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "temp-password.json"},
     {"values" => {"no_of_records" => "50","page_no" => "1"}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "search.json"},
     {"values" => {"customer_id" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "delete.json"},
     {"values" => {},"http_method" => "get", "validate" => lambda {|v| true}, "url" => "generate-token.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "authenticate-token.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "promo-details.json"},
    ].each { |p| build_method p }
  end

end
