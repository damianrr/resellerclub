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
    ].each { |p| build_method p }

  end
end

# puts(Domain.availability({"domain-name" => ["damian"], "tlds" => ["net", "com"], "suggest-alternative" => "true"}))
# puts(Domain.idn_availability({"domain-name" => "españa", "tld" => "es", "idnLanguageCode" => "es"}))
# puts(Domain.suggest_names({"keyword" => "ipad", "tlds" => ["com", "net"], "hypen-allowed" => "true", "add-related" => "true", "no-of-results" => "5"}))
puts(Domain.register({"domain-name" => "damianrr.com", "years" => "1", "ns" => ["my.first.domain.com", "my.second.domain.com"], "customer_id" => "8989245", "reg-contact-id" => "25052632", "admin-contact-id" => "25052632", "tech-contact-id" => "25052632", "billing-contact-id" => "25052632", "invoice-option" => "KeepInvoice", "protect-privacy" => "true"}))
