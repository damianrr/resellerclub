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
