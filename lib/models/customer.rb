require_relative '../mixin.rb'

class Customer
  class << self
    BASE_URL = "https://test.httpapi.com/api/customers/"

    extend ResellerClubMethods

    [{"values" => {"lang_pref" => "en"}, "method_name" => "add", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "signup.json"},
     {"values" => {"lang_pref" => "en"}, "method_name" => "update", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "modify.json"},
     {"values" => {"username" => ""}, "method_name" => "get_by_username", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "details.json"},
     {"values" => {"customer_id" => ""}, "method_name" => "get_by_id", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "details-by-id.json"},
     {"values" => {}, "method_name" => "change_password", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "change-password.json"},
     {"values" => {"customer_id" => ""}, "method_name" => "generate_password", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "temp-password.json"},
     {"values" => {"no_of_records" => "50","page_no" => "1"}, "method_name" => "search", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "search.json"},
     {"values" => {"customer_id" => ""}, "method_name" => "delete", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "delete.json"},
     {"values" => {}, "method_name" => "generate_token", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "generate-token.json"},
     {"values" => {"token" => ""}, "method_name" => "authenticate_token", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "authenticate-token.json"},
    ].each { |p| build_method p }

  end
end
