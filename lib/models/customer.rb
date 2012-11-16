require_relative '../mixin.rb'

# Example of use: Customer.add({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "56 st pensilvania", "company" => "Transmeta", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531"})
# Example of use: Customer.update({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "my casa", "company" => "my company.corb", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","customer_id"=> "8940466"})
# Example of use: Customer.get_by_username("damian@google.com")
# Example of use: Customer.change_password("customer_id" => "8989245", "new_passwd" => "newpasswd1")
# Example of use: Customer.generate_password("8989245")
# Example of use: Customer.search("name" => "Tyler")
# Example of use: Customer.delete("8961835")
# Example of use: Customer.generate_token("username" => "damian@google.com", "passwd" => "PRnHZBEL", "ip" => "200.55.139.34")
# Example of use: Customer.authenticate_token("IQJMlIJZ")

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
