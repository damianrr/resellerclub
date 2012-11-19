require "rubygems"
require "typhoeus"
require "open-uri"
require "json"
require "pry"

module ResellerClubMethods

  AUTH_USERID = "123456"
  AUTH_PASSWORD = "myresellerpass"

  def true_false_or_text(str)
    if str == "true"
      return {"response" => true}.to_json
    elsif str == "false"
      return {"response" => false}.to_json
    elsif str.to_i.to_s == str
      return {"code" => str}.to_json
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
    url = self::BASE_URL + method + "?"
    params.each do |k,v|
      if v.kind_of?(Array)
        v.each { |elem| url = url + k.gsub("_","-") + "=" + elem + "&"}
      else
        url = url + k.gsub("_","-") + "=" + v + "&"
      end
    end
    if url[-1] == "&"
      url = url[0..-2]
    end
    URI::encode(url)
  end

  def build_method(data)
    construct_url_bind = method(:construct_url)
    true_false_or_text_bind = method(:true_false_or_text)
    define_method data["method_name"] do |params=nil|
      if data["values"].nil?
        data["values"] = {}
      elsif data["values"].keys.count == 1 and (data["values"].values)[0] == ""
        data["values"][(data["values"].keys)[0]] = params
      else
        data["values"].merge!(params)
      end
      if not data["values"].keys.include? "auth_userid" and not data["values"].keys.include? "auth_password"
        data["values"]["auth_userid"] = AUTH_USERID
        data["values"]["auth_password"] = AUTH_PASSWORD
      end
      if data["validate"].call(data["values"])
        url = construct_url_bind.call(data["values"], data["url"])
        puts url
        if data["silent"]
          Typhoeus::Request.send data["http_method"], url
        else
          response = Typhoeus::Request.send data["http_method"], url
          case response.code
          when 200
            return JSON.parse(true_false_or_text_bind.call(response.body))
          when 500
            error = JSON.parse(true_false_or_text_bind.call(response.body))
            raise error["message"]
          when 404
            raise "Action not Found"
          else
            error = JSON.parse(true_false_or_text_bind.call(response.body))
            raise error["message"]
          end
        end
      else
        raise "Validation failed."
      end
    end
  end
end
