# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class ResellerClubDns
  class << self
    BASE_URL = "https://test.httpapi.com/api/dns/"

    extend ResellerClub

    [
      {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "activate.json"},
      {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "manage/add-cname-record.json"},
      {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "manage/update-cname-record.json"},
      {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "manage/add-ns-record.json"},
      {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "manage/update-ns-record.json"}
    ].each { |p| build_method p }
      ['add-ipv4-record.json','add-mx-record.json','add-ipv6-record.json','add-txt-record.json','update-ipv4-record.json'].each do |p| 
        build_method({"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => p})
      end
  end
end
