# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class ResellerClubOrder
  class << self
    BASE_URL = "https://test.httpapi.com/api/orders/"

    extend ResellerClub

    [{"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "suspend.json"},
     {"values" => {"order_id" => ""}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "unsuspend.json"},
    ].each { |p| build_method p }

  end
end
