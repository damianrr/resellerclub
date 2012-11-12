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
    return "create", values.merge!(params)
  end

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
    return "update", values.merge!(params)
  end

  def get_by_username(params) # params should be {:username => "...."}
    values = {
      "username" => ""         # Should be an email address. Required
    }
    values = values.merge!(params)
    if validate(values)
      url = construct_url(values, "get_by_username")
      response = Typhoeus::Request.get(url)
      case response.code
      when 200
        return JSON.parse(response.body)
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    else
      raise "Validation failed."
    end
  end

  def get_by_id(params)  # params should be {:customer_id => "...."}
    values = {
      "customer_id" => "",
    }
    values = values.merge!(params)
    if validate(values)
      url = construct_url(values, "get_by_id")
      response = Typhoeus::Request.get(url)
      case response.code
      when 200
        return JSON.parse(response.body)
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    else
      raise "Validation failed."
    end
  end

  def change_password(customer_id, password)
    values = {
      "customer_id" => customer_id.to_s,
      "new_passwd" => password.to_s,
    }
    if validate(values)
      url = construct_url(values, "change_password")
      response = Typhoeus::Request.post(url)
      case response.code
      when 200
        true_or_false(response.body)
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    else
      raise "Validation failed."
    end
  end

  def generate_password(customer_id)
    values = {
      "customer_id" => customer_id.to_s,
    }
    if validate(values)
      url = construct_url(values, "generate_password")
      response = Typhoeus::Request.get(url)
      case response.code
      when 200
        return response.body
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    else
      raise "Validation failed."
    end
  end

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
    values = values.merge!(params)
    if validate(values)
      url = construct_url(values, "search")
      response = Typhoeus::Request.get(url)
      case response.code
      when 200
        return JSON.parse(response.body)
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    end
  end

  def delete(customer_id)
    # Example of use: Customer.delete("8961835")
    values = {
      "customer_id" => customer_id.to_s,
    }
    if validate(values)
      url = construct_url(values, "delete")
      response = Typhoeus::Request.get(url)
      case response.code
      when 200
        return true_or_false(response.body)
      when 500
        error = JSON.parse(response.body)
        raise error["message"]
      end
    else
      raise "Validation failed."
    end
  end

  def self.validate(params)
    true
  end

end
