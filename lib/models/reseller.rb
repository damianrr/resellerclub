require_relative '../decorators.rb'

class Reseller

  extend DecorateResellerClubModels

  +ResellerDecorator
  def add(params={})
    # Reseller.add({"username" => "r@reseller.com","passwd" => "tambi5en5","name" => "My reseller","address_line_1" => "et telefono mi casa", "company" => "Seller", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","accounting_currency_symbol" => "USD", "selling_currency_symbol" => "USD", "sales_contact_id" => "0"})
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
      "accounting_currency_symbol" => "", # Accounting currency symbol of reseller
      "selling_currency_symbol" => "",    # Required Selling currency symbol of reseller
      "sales_contact_id" => "",           # Optional Sales userID of parent reseller
    }
    return "create", "post", values.merge!(params), true
  end

  +ResellerDecorator
  def update(params={})
    # Example of use: Reseller.update({"username" => "cambio@google.com","passwd" => "tambi5en5","name" => "CambioNomb","address_line_1" => "my casa", "company" => "my company.corb", "city" => "Lisa", "state" => "CH", "country" => "CU", "zipcode" => "11155", "phone_cc" => "53", "phone" => "531531","reseller_id"=> "433154", "accounting_currency_symbol" => "CUC", "selling_currency_symbol" => "CUC", "website_url" => "http://aaa.aaa.aaa"})
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
      "accounting_currency_symbol" => "", # Accounting currency symbol of reseller
      "selling_currency_symbol" => "",    # Required Selling currency symbol of reseller
      "sales_contact_id" => "",           # Optional Sales userID of parent reseller
      "brand_name" => "",  # Optional Brand name used for branding.
      "website_url" => "", #  String Optional Branded website URL.
      "reseller_id" => "", # Required ResellerId of the sub-reseller for whom the details need to be modified.
    }
    return "update", "post", values.merge!(params), true
  end

  +ResellerDecorator
  def get_details(reseller_id)
    # Example of use: Reseller.get_details("433154")
    values = {
      "reseller_id" => reseller_id.to_s,
    }
    return "details", "get", values, true
  end

  +ResellerDecorator
  def generate_password(reseller_id)
    # Example of use: Reseller.generate_password("433154")
    values = {
      "reseller_id" => reseller_id.to_s,
    }
    return "generate_password", "get", values, true
  end

  +ResellerDecorator
  def search(params={})
    # Example of use: Reseller.search("name" => "Tyler")
    values = {
      "no_of_records" => "50",
      "page_no" => "1",
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

  +ResellerDecorator
  def generate_token(params={})
    # Example of use: Reseller.generate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "ip" => "200.55.139.34")
    values = {
      "auth_userid" => "",
      "auth_password" => "",
      "ip" => "",
    }
    return "generate_token", "get", values.merge!(params), true
  end

  +ResellerDecorator
  def authenticate_token(params)
    # Example of use: Reseller.authenticate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "token" => "token")
    values = {
      "auth_userid" => "",
      "auth_password" => "",
      "token" => "",    # Required
    }
    return "auth_token", "get", values.merge!(params), true
  end

  +ResellerDecorator
  def promo_prices(params={})
    # Example of use: Reseller.promo_prices("auth_userid" => "433154", "auth_password" => "lV6UAIxi")
    values = {
      "auth_userid" => "",
      "auth_password" => "",
    }
    # Example of use: Reseller.promo_prices()
    return "promo_prices", "get", values.merge!(params), true
  end
end

puts(Reseller.authenticate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "token" => "aaa"))
