require_relative '../decorators.rb'

class Customer

  extend DecorateResellerClubModels

  +CustomerDecorator
  def add(params={})
    # Example of use: Customer.add({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "56 st pensilvania", "company" => "Transmeta", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531"})
    values = {
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
    return "create", "post", values.merge!(params), true
  end

  +CustomerDecorator
  def update(params={})
    # Example of use: Customer.update({"username" => "tyler@google.com","passwd" => "tambi5en5","name" => "Tyler","address_line_1" => "my casa", "company" => "my company.corb", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","customer_id"=> "8940466"})
    # Note: we cannot only pass the values we want to change, but all.
    values = {
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
    return "update", "post", values.merge!(params), true
  end

  +CustomerDecorator
  def get_by_username(customer_id)
    # Example of use: Customer.get_by_username("damian@google.com")
    values = {
      "username" => customer_id.to_s      # Should be an email address. Required
    }
    return "get_by_username", "get", values, true
  end

  +CustomerDecorator
  def get_by_id(customer_id)  # params should be {:customer_id => "...."}
    # Example of use: Customer.get_by_id("8989245")
    values = {
      "customer_id" => customer_id.to_s,
    }
    return "get_by_id", "get", values, true
  end

  +CustomerDecorator
  def change_password(params={})
    # Example of use: Customer.change_password("customer_id" => "8989245", "new_passwd" => "newpasswd1")
    return "change_password", "get", params, true
  end

  +CustomerDecorator
  def generate_password(customer_id)
    # Example of use: Customer.generate_password("8989245")
    values = {
      "customer_id" => customer_id.to_s,
    }
    return "generate_password", "get", values, true
  end

  +CustomerDecorator
  def search(params={})
    # Example of use: Customer.search("name" => "Tyler")
    values = {
      "no_of_records" => "50",
      "page_no" => "1",
      "customer_id" => "",
      "reseller_id" => "",
      "username" => "",
      "name" => "",
      "company" => "",
      "city" => "",
      "state" => "",
      "status" => "",
      "creation_date_start" => "",
      "creation_date_end" => "",
      "total_receipt_start" => "",
      "total_receipt_end" => "",
    }
    return "search", "get", values.merge!(params), true
  end

  +CustomerDecorator
  def delete(customer_id)
    # Example of use: Customer.delete("8961835")
    values = {
      "customer_id" => customer_id.to_s,
    }
    return "delete", "post", values, true
  end

  +CustomerDecorator
  def generate_token(params={})
    # Example of use: Customer.generate_token("username" => "damian@google.com", "passwd" => "PRnHZBEL", "ip" => "200.55.139.34")
    values = {
      "username" => "",
      "passwd" => "",
      "ip" => "",
    }
    return "generate_token", "get", values.merge!(params), true
  end

  +CustomerDecorator
  def authenticate_token(token)
    # Example of use: Customer.authenticate_token("IQJMlIJZ")
    values = {
      "token" => token.to_s,    # Required
    }
    return "auth_token", "get", values, true
  end
end
