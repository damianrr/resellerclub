require "rubygems"
require "rubygems"
require "typhoeus"
require "open-uri"
require "json"
require "ruby_decorators"
require "pry"


module DecorateResellerClubModels
  include RubyDecorators
  @@instance = nil

  def self.extended(base)
    @@instance = base.new
  end

  def method_missing name, *args, &block
    @@instance.send name, *args, &block
  end

end

class CustomerDecorator < RubyDecorator

  @@base_url = "https://test.httpapi.com/api/customers/"
  @@action_urls = {"create" => "signup.json", "update" => "modify.json", "get_by_username" => "details.json", "get_by_id" => "details-by-id.json", "change_password" => "change-password.json", "generate_password" => "temp-password.json", "search" => "search.json", "delete" => "delete.json"}
  @@auth_userid = "123456"
  @@auth_password = "myresellerpass"

  def validate(v)
    true
  end


  def true_false_or_text(str)
    if str == "true"
      return true
    elsif str == "false"
      return false
    else
      return str
    end
  end

  def construct_url(params, method)
    params.delete_if {|k,v| v == ""}
    url = @@base_url + @@action_urls[method] + "?"
    params.each {|k,v| url = url + k.gsub("_","-") + "=" + v + "&"}
    if url[-1] == "&"
      url = url[0..-2]
    end
    URI::encode(url)
  end

  def call(this, params, &blk)
    method, values = this.call(params, &blk)
    values["auth_userid"] = @@auth_userid
    values["auth_password"] = @@auth_password
    values = values.merge!(params)
    if validate(values)
      url = construct_url(values, "create")
      binding.pry
      # Typhoeus::Request.post(url)
    else
      raise "Validation failed."
    end
  end

end
