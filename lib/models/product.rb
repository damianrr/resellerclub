# -*- coding: utf-8 -*-
require_relative '../mixin.rb'

class Product
  class << self
    BASE_URL = "https://test.httpapi.com/api/products/"

    extend ResellerClub

    [
     {"values" => {}, "http_method" => "post", "validate" => lambda {|v| true}, "url" => "move.json"},
    ].each { |p| build_method p }

  end
end
