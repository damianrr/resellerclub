# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Contact
  class << self
    BASE_URL = "https://test.httpapi.com/api/contacts/"

    extend ResellerClub

    [{"values" => {}, "http_method" => "post",  "validate" => lambda {|v| true}, "url" => "add.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify.json"},
     {"values" => {"contact_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "details.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "default.json"},
     {"values" => {"no_of_records" => "50","page_no" => "1"}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "search.json"},
     {"values" => {"contact_id" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "delete.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "set-details.json"},
     {"values" => {"customer_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "sponsors.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "coop/add-sponsor.json"},
     {"values" => nil, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "dotca/registrantagreement.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "validate-registrant.json"},
    ].each { |p| build_method p }

  end

end
