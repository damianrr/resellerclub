# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Order
  class << self
    BASE_URL = "https://test.httpapi.com/api/orders/"

    extend ResellerClubMethods

    def validate
      true
    end

    [{"values" => {}, "method_name" => "suspend", "http_method" => "post", "validate" => validate, "url" => "suspend.json"},
     {"values" => {"order_id" => ""}, "method_name" => "unsuspend", "http_method" => "post", "validate" => validate, "url" => "idn-unsuspend.json"},
    ].each { |p| build_method p }

  end
end
