# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Contact
  class << self
    BASE_URL = "https://test.httpapi.com/api/contacts/"

    extend ResellerClubMethods

    [{"values" => {"lang_pref" => "en"}, "method_name" => "add", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "add.json"},
     {"values" => {"lang_pref" => "en"}, "method_name" => "update", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "modify.json"},
     {"values" => {"contact_id" => ""}, "method_name" => "details", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "details.json"},
     {"values" => {}, "method_name" => "get_default", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "default.json"},
     {"values" => {"no_of_records" => "50","page_no" => "1"}, "method_name" => "search", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "search.json"},
     {"values" => {"contact_id" => ""}, "method_name" => "delete", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "delete.json"},
     {"values" => {}, "method_name" => "set_extra_details", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "set-details.json"},
     {"values" => {"customer_id" => ""}, "method_name" => "sponsors", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "sponsors.json"},
     {"values" => {}, "method_name" => "add_sponsor", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "coop/add-sponsor.json"},
     {"values" => nil, "method_name" => "registrant_agreement", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "dotca/registrantagreement.json"},
     {"values" => {}, "method_name" => "validates_contact_against_criteria", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "validate-registrant.json"},
    ].each { |p| build_method p }

  end

end

# puts(Contact.add({"name" => "Damian", "company" => "Home", "email" => "home@damian.com", "address-line-1" => "196 lisa", "city" => "havana", "country" => "US", "zipcode" => "11500", "phone-cc" => "53", "phone" => "535353", "customer-id" => "8989245", "type" => "Contact"}))

# puts(Contact.update({"name" => "Tomates Real Tomates", "company" => "my company", "email" => "tomates@whatsup.com", "address-line-1" => "196 lisa", "city" => "havana", "country" => "CU", "zipcode" => "11500", "phone-cc" => "53", "phone" => "535353", "customer-id" => "8989245", "type" => "Contact", "contact-id" => "25049249"}))

# puts(Contact.details("25050309"))

# puts(Contact.search({"name" => "Verdaderos Tomates", "customer-id" => "8989245"}))

# puts(Contact.get_default({"type" => "Contact", "customer-id" => "8989245"}))

# puts(Contact.delete("25049249"))

# puts(Contact.set_extra_details({"contact_id" => "25050309", "product-key" => "dotca", "attr-name1" => "sponsor1", "attr-value1" => "-200"}))

# puts(Contact.sponsors("8989245"))

# puts(Contact.add_sponsor({"name" => "Mi esponsor", "company" => "la de los sponsors", "email" => "esponsor@sponsors.com", "address-line-1" => "calle sponsor", "city" => "sponsor", "country" => "CU", "zipcode" => "11500", "phone-cc" => "53", "phone" => "531531", "customer-id" => "8989245"}))

# puts(Contact.registrant_agreement())

# OjO: Esta func normalmente acepta varios parametros con el nombre: eligibility-criteria, debido a que se utilizan hashes para almacenar estos parametros la func debera ser utilizada de la siguiente forma (O sea solo una llave conteniendo un array de las variables opciones):
# puts(Contact.validates_contact_against_criteria({"contact_id" => "25050309", "eligibility-criteria" => ["APP_PREF_NEXUS", "Tomates"]}))
