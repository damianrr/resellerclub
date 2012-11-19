require_relative '../mixin.rb'

# Reseller.add({"username" => "r@reseller.com","passwd" => "tambi5en5","name" => "My reseller","address_line_1" => "et telefono mi casa", "company" => "Seller", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","accounting_currency_symbol" => "USD", "selling_currency_symbol" => "USD", "sales_contact_id" => "0"})
# Example of use: Reseller.update({"username" => "cambio@google.com","passwd" => "tambi5en5","name" => "CambioNomb","address_line_1" => "my casa", "company" => "my company.corb", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","reseller_id"=> "433154", "accounting_currency_symbol" => "CUC", "selling_currency_symbol" => "CUC", "website_url" => "http://aaa.aaa.aaa"})
# Example of use: Reseller.get_details("433154")
# Example of use: Reseller.generate_password("433154")
# Example of use: Reseller.search("name" => "Tyler")
# Example of use: Reseller.generate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "ip" => "200.55.139.34")
# Example of use: Reseller.authenticate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "token" => "token")
# Example of use: Reseller.promo_prices("auth_userid" => "433154", "auth_password" => "lV6UAIxi")


class Reseller
  class << self
    BASE_URL = "https://test.httpapi.com/api/customers/"

    extend ResellerClubMethods

    [{"values" => {"lang_pref" => "en"}, "method_name" => "add", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "signup.json"},
     {"values" => {"lang_pref" => "en"}, "method_name" => "update", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "modify-details.json"},
     {"values" => {"reseller_id" => ""}, "method_name" => "get_details", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "details.json"},
     {"values" => {"reseller_id" => ""}, "method_name" => "generate_password", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "temp-password.json"},
     {"values" => {"no_of_records" => "50","page_no" => "1"}, "method_name" => "search", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "search.json"},
     {"values" => {"customer_id" => ""}, "method_name" => "delete", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "delete.json"},
     {"values" => {}, "method_name" => "generate_token", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "generate-token.json"},
     {"values" => {}, "method_name" => "authenticate_token", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "authenticate-token.json"},
     {"values" => {}, "method_name" => "promo_prices", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "promo-details.json"},
    ].each { |p| build_method p }
  end

end
