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


class ResellerClubDecorators < RubyDecorator
  @@auth_userid = "123456"
  @@auth_password = "myresellerpass"
  @@base_url = ""
  @@action_urls = ""

  def validate(v)
    true
  end

  def true_false_or_text(str)
    if str == "true"
      return {"response" => true}.to_json
    elsif str == "false"
      return {"response" => false}.to_json
    elsif str.to_i.to_s == str
      return {"code" => str}
    else
      begin
        JSON.parse(str)
      rescue
        return {"response" => str}.to_json
      end
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
    fname, method, values, response = this.call(params, &blk)
    values["auth_userid"] = @@auth_userid
    values["auth_password"] = @@auth_password
    if validate(values)
      url = construct_url(values, fname)
      if response
        response = Typhoeus::Request.send method, url
        case response.code
        when 200
          return JSON.parse(true_false_or_text(response.body))
        when 500
          error = JSON.parse(true_false_or_text(response.body))
          raise error["message"]
        end
      else
        Typhoeus::Request.send method, url
      end
    else
      raise "Validation failed."
    end
  end


end

class CustomerDecorator < ResellerClubDecorators
  @@base_url = "https://test.httpapi.com/api/customers/"
  @@action_urls = {"create" => "signup.json", "update" => "modify.json", "get_by_username" => "details.json", "get_by_id" => "details-by-id.json", "change_password" => "change-password.json", "generate_password" => "temp-password.json", "search" => "search.json", "delete" => "delete.json", "generate_token" => "generate-token.json", "auth_token" => "authenticate-token.json"}
end
