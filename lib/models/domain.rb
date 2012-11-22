# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Domain
  class << self
    BASE_URL = "https://test.httpapi.com/api/domains/"

    extend ResellerClubMethods

    [{"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "available.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "idn-available.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "suggest-names.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "register.json"},
     {"values" => {"domain-name" => ""},"http_method" => "get", "validate" => lambda {|v| true}, "url" => "validate-transfer.json"},
     {"values" => {"domain-name" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "transfer.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "eu/transfer.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "trade.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "renew.json"},

     # Check the http method and parameters from here also test
     {"values" => {"no-of-records" => "10", "page-no" => "1"}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "search.json"},
     {"values" => {"customer_id" => ""}, "http_method" => "get","validate" => lambda {|v| true}, "url" => "customer-default-ns.json"},
     {"values" => {"domain_name" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "orderid.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "details.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-ns.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "add-cns.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-cns-name.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-cns-ip.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "delete-cns-ip.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-contact.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-privacy-protection"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "modify-auth-code.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "enable-theft-protection.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "disable-theft-protection.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "locks.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "cth-details.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "/tel/modify-whois-pref.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "resend-rfa.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "uk/release.json"},
     {"values" => {"order_id" => ""}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "cancel-transfer.json"},
     {"values" => {"order_id" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "delete.json"},
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "restore.json"},
     {"values" => {"order_id" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "de/recheck-ns.json"},
     {"values" => {}, "http_method" => "get", "validate" => lambda {|v| true}, "url" => "dotxxx/association-details.json"},
    ].each { |p| build_method p }

  end
end
