# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Domain
  class << self
    BASE_URL = "https://test.httpapi.com/api/domains/"

    extend ResellerClubMethods

    def validate
      true
    end

    [{"values" => {}, "method_name" => "availability", "http_method" => "post", "validate" => validate, "url" => "available.json"},
     {"values" => {}, "method_name" => "idn_availability", "http_method" => "post", "validate" => validate, "url" => "idn-available.json"},
     {"values" => {}, "method_name" => "suggest_names", "http_method" => "post", "validate" => validate, "url" => "suggest-names.json"},
     {"values" => {}, "method_name" => "register", "http_method" => "post", "validate" => validate, "url" => "register.json"},
     {"values" => {"domain-name" => ""}, "method_name" => "validate_transfer", "http_method" => "get", "validate" => validate, "url" => "validate-transfer.json"},
     {"values" => {"domain-name" => ""}, "method_name" => "transfer", "http_method" => "post", "validate" => validate, "url" => "transfer.json"},
     {"values" => {}, "method_name" => "transfer_eu", "http_method" => "post", "validate" => validate, "url" => "eu/transfer.json"},
     {"values" => {}, "method_name" => "trade", "http_method" => "post", "validate" => validate, "url" => "trade.json"},
     {"values" => {}, "method_name" => "renew", "http_method" => "post", "validate" => validate, "url" => "renew.json"},

     # Check the http method and parameters from here also test
     {"values" => {"no-of-records" => "10", "page-no" => "1"}, "method_name" => "search", "http_method" => "get", "validate" => validate, "url" => "search.json"},
     {"values" => {"customer_id" => ""},"method_name" => "customer_default_ns","http_method" => "get","validate" => validate, "url" => "customer-default-ns.json"},
     {"values" => {"domain_name" => ""}, "method_name" => "orderid", "http_method" => "get", "validate" => validate, "url" => "orderid.json"},
     {"values" => {}, "method_name" => "details", "http_method" => "get", "validate" => validate, "url" => "details.json"},
     {"values" => {}, "method_name" => "modify_ns", "http_method" => "post", "validate" => validate, "url" => "modify-ns.json"},
     {"values" => {}, "method_name" => "add_cns", "http_method" => "post", "validate" => validate, "url" => "add-cns.json"},
     {"values" => {}, "method_name" => "modify_cns_name", "http_method" => "post", "validate" => validate, "url" => "modify-cns-name.json"},
     {"values" => {}, "method_name" => "modify_cns_ip", "http_method" => "post", "validate" => validate, "url" => "modify-cns-ip.json"},
     {"values" => {}, "method_name" => "delete_cns_ip", "http_method" => "post", "validate" => validate, "url" => "delete-cns-ip.json"},
     {"values" => {}, "method_name" => "modify_contact", "http_method" => "post", "validate" => validate, "url" => "modify-contact.json"},
     {"values" => {}, "method_name" => "modify-privacy-protection", "http_method" => "post", "validate" => validate, "url" => "modify-privacy-protection"},
     {"values" => {}, "method_name" => "modify_auth_code", "http_method" => "post", "validate" => validate, "url" => "modify-auth-code.json"},
     {"values" => {"order_id" => ""}, "method_name" => "enable_theft_protection", "http_method" => "get", "validate" => validate, "url" => "enable-theft-protection.json"},
     {"values" => {"order_id" => ""}, "method_name" => "disable_theft_protection", "http_method" => "get", "validate" => validate, "url" => "disable-theft-protection.json"},
     {"values" => {"order_id" => ""}, "method_name" => "locks", "http_method" => "get", "validate" => validate, "url" => "locks.json"},
     {"values" => {"order_id" => ""}, "method_name" => "cth_details", "http_method" => "get", "validate" => validate, "url" => "cth-details.json"},
     {"values" => {}, "method_name" => "modify_whois_pref", "http_method" => "post", "validate" => validate, "url" => "/tel/modify-whois-pref.json"},
     {"values" => {"order_id" => ""}, "method_name" => "resend_rfa", "http_method" => "get", "validate" => validate, "url" => "resend-rfa.json"},
     {"values" => {}, "method_name" => "uk_release", "http_method" => "get", "validate" => validate, "url" => "uk/release.json"},
     {"values" => {"order_id" => ""}, "method_name" => "cancel_transfer", "http_method" => "get", "validate" => validate, "url" => "cancel-transfer.json"},
     {"values" => {"order_id" => ""}, "method_name" => "delete", "http_method" => "post", "validate" => validate, "url" => "delete.json"},
     {"values" => {}, "method_name" => "restore", "http_method" => "post", "validate" => validate, "url" => "restore.json"},
     {"values" => {"order_id" => ""}, "method_name" => "de_recheck_ns", "http_method" => "post", "validate" => validate, "url" => "de/recheck-ns.json"},
     {"values" => {}, "method_name" => "assocciation_details", "http_method" => "get", "validate" => validate, "url" => "dotxxx/association-details.json"},
    ].each { |p| build_method p }

  end
end
