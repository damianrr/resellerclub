# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Domain
  class << self
    BASE_URL = "https://test.httpapi.com/api/domains/"

    extend ResellerClubMethods

    [{"values" => {}, "method_name" => "availability", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "available.json"},
     {"values" => {}, "method_name" => "idn_availability", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "idn-available.json"},
     {"values" => {}, "method_name" => "suggest_names", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "suggest-names.json"},
     {"values" => {}, "method_name" => "register", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "register.json"},
     {"values" => {"domain-name" => ""}, "method_name" => "validate_transfer", "http_method" => "get",
       "validate" => lambda { |values| true }, "url" => "validate-transfer.json"},
     {"values" => {"domain-name" => ""}, "method_name" => "transfer", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "transfer.json"},
     {"values" => {}, "method_name" => "transfer_eu", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "eu/transfer.json"},
     {"values" => {}, "method_name" => "trade", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "trade.json"},
     {"values" => {}, "method_name" => "renew", "http_method" => "post",
       "validate" => lambda { |values| true }, "url" => "renew.json"},

    ].each { |p| build_method p }

  end
end

# puts(Domain.availability({"domain-name" => ["damian"], "tlds" => ["net", "com"], "suggest-alternative" => "true"}))
# puts(Domain.idn_availability({"domain-name" => "españa", "tld" => "es", "idnLanguageCode" => "es"}))
# puts(Domain.suggest_names({"keyword" => "ipad", "tlds" => ["com", "net"], "hypen-allowed" => "true", "add-related" => "true", "no-of-results" => "5"}))
# puts(Domain.register({"domain-name" => "damianrr.com", "years" => "1", "ns" => ["nameserver.com"], "customer_id" => "8989245", "reg-contact-id" => "25052632", "admin-contact-id" => "25052632", "tech-contact-id" => "25052632", "billing-contact-id" => "25052632", "invoice-option" => "NoInvoice", "protect-privacy" => "true"}))
# puts(Domain.validate_transfer("google.com"))

# Not Tested
# puts(Domain.transfer({"domain-name" => "domain.asia", "auth-code" => "auth-code", "ns" => "ns1.domain.com", "ns" => "ns2.domain.com", "customer-id" => "0", "reg-contact-id" => "0", "admin-contact-id" => "0", "tech-contact-id" => "0", "billing-contact-id" => "0", "invoice-option" => "KeepInvoice", "protect-privacy" => "false", "attr-name1" => "cedcontactid", "attr-value1" => "0"}))

# puts(Domain.transfer_eu({"domain-name" => "domain.eu", "customer-id" => "0", "invoice-option" => "NoInvoice", "ns" => ["ns1.domain.org", "ns2.domain.org"], "cns1" => "ns1.domain.eu", "ip1" => "0.0.0.0,1.1.1.1", "cns2" => "ns2.domain.eu", "ip2" => "0.0.0.0,1.1.1.1"}))

# puts(Domain.trade({"domain-name" => "domain.eu", "customer-id" => "0", "invoice-option" => "NoInvoice", "ns" => ["ns1.domain.org", "ns2.domain.org"], "cns1" => "ns1.domain.eu", "ip1" => "0.0.0.0,1.1.1.1", "cns2" => "ns2.domain.eu", "ip2" => "0.0.0.0,1.1.1.1", "reg-contact-id" => "0"}))

# puts(Domain.renew({"order-id" => "46983636", "years" => "1", "exp-date" => "1353825293", "invoice-option" => "NoInvoice"}))
