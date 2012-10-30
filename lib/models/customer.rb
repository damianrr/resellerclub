require "rubygems"
require "typhoeus"
require "open-uri"
require "pry"

class Customer
  @@url = "https://httpapi.com/api/customers/"
  @@url_add = "signup.json"
  @@url_update = "modify.json"
  @@auth_userid = "430162"
  @@auth_password = "myresellerpass"
  class << self
    def construct_url(params, method)
      m = case method
          when "create"
            @@url_add
          when "update"
            @@url_update
          end
      params.delete_if {|k,v| v == ""}
      url = @@url + m + "?"
      params.each {|k,v| url = url + k.gsub("_","-") + "=" + v + "&"}
      if url[-1] == "&"
        url = url[0..-2]
      end
      URI::encode(url)
    end

    def validate(params)
      true
    end

    def add(params={})
      # Example of use: Customer.add({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "56 st pensilvania", "company" => "Transmeta", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531"})
      values = {
        "auth_userid" => @@auth_userid,
        "auth_password" => @@auth_password,
        "username" => "",         # Should be an email address, required
        "passwd" => "",           # Should be alphanumeric with a minimum of 8 and maximum of 16 characters. Required
        "name" => "",             # Required
        "company" => "",          # Required
        "address_line_1" => "",   # Required
        "address_line_2" => "",
        "address_line_3" => "",
        "city" => "",             # Required
        "state" => "",            # Required
        "country" => "",          # Country Code as per ISO 3166-1 alpha-2.
        "zipcode" => "",          # Required
        "phone" => "",            # Required
        "alt_phone" => "",
        "alt_phone_cc" => "",     # Alternate phone Country Code.
        "phone_cc" => "",         # Telephone number Country Code. Required
        "lang_pref" => "en",      # Language Code as per ISO. Required
        "fax" => "",
        "fax_cc" => "",           # Fax country code.
        "mobile" => "",
        "mobile_cc" => "",        # Mobile country code.
      }
      values = values.merge!(params)
      if validate(values)
        url = construct_url(values, "create")
        # Typhoeus::Request.post(url)
      else
        raise "Validation failed."
      end
    end

    def update(params={})
      # Example of use: Customer.update({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "my casa", "company" => "my company.corb", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","customer_id"=> "8940466"})
      # Note: we cannot only pass the values we want to change, but all.
      values = {
        "auth_userid" => @@auth_userid,
        "auth_password" => @@auth_password,
        "username" => "",         # Should be an email address, required
        "passwd" => "",           # Should be alphanumeric with a minimum of 8 and maximum of 16 characters. Required
        "name" => "",             # Required
        "company" => "",          # Required
        "address_line_1" => "",   # Required
        "address_line_2" => "",
        "address_line_3" => "",
        "city" => "",             # Required
        "state" => "",            # Required
        "country" => "",          # Country Code as per ISO 3166-1 alpha-2.
        "zipcode" => "",          # Required
        "phone" => "",            # Required
        "alt_phone" => "",
        "alt_phone_cc" => "",     # Alternate phone Country Code.
        "phone_cc" => "",         # Telephone number Country Code. Required
        "lang_pref" => "en",      # Language Code as per ISO. Required
        "fax" => "",
        "fax_cc" => "",           # Fax country code.
        "mobile" => "",
        "mobile_cc" => "",        # Mobile country code.
        "customer_id" => "",      # Required
      }
      values = values.merge!(params)
      if validate(values)
        url = construct_url(values, "update")
        Typhoeus::Request.post(url)
      else
        raise "Validation failed."
      end

    end
  end
end
