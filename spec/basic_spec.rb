# -*- coding: utf-8 -*-
require 'rspec'
require 'json_spec'
require 'rack/test'
require 'rspec/expectations'
require_relative '../lib/models/customer.rb'
require_relative '../lib/models/reseller.rb'
require_relative '../lib/models/contact.rb'
require_relative '../lib/models/domain.rb'
require_relative '../lib/models/order.rb'
require_relative '../lib/mixin.rb'
require "pry"
require "open-uri"

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include JsonSpec::Helpers
end

def hashify_url_params(params)
  hash = {}
  div_params = params.split('&').each do |str|
    k,v = str.split("=")
    hash[k] = v
  end
  hash
end

def eql_urls(url1, url2)
  url1, params1 = url1.split("?")
  url2, params2 = url2.split("?")
  params = hashify_url_params(params1) == hashify_url_params(params2)
  urls = url1 == url2
  if params and urls
    return true
  end
  return false
end

Spec::Matchers.define :be_eql_url do |original_url|
  match do |generated_url|
    eql_urls(generated_url, URI::encode(original_url))
  end
  failure_message_for_should do |generated_url|
    diff = []
    gen_url, gen_params = generated_url.split("?")
    orig_url, orig_params = URI::encode(original_url).split("?")
    if orig_params != gen_params
      gen_params = hashify_url_params(gen_params)
      orig_params = hashify_url_params(orig_params)
      gen_params.each {|k, v| diff << [k, {"origin" => orig_params[k], "generated" => gen_params[k]}] if orig_params[k] != v }
      orig_params.each {|k, v| diff << [k, {"origin" => orig_params[k], "generated" => gen_params[k]}] if gen_params[k] != v }
    elsif gen_url != orig_url

    end
    "expected: #{generated_url} \n got: #{original_url} \n difference: #{diff}"
  end
  failure_message_for_should_not do |generated_url|
    "expected: #{generated_url} \n to be different from: #{original_url}"
  end
end


describe 'Reseller Club Models' do
  include Rack::Test::Methods

  context "Testing Customer Model" do

    before(:all) do
      # WARNING! Change `123456` for a real Reseller id and `myresellerpass` for the password of that reseller account across all the file
      ResellerClub::authentication("123456", "myresellerpass")
    end

    it "should generate a correct url for signup" do
      org_url = "https://test.httpapi.com/api/customers/signup.json?auth-userid=123456&auth-password=myresellerpass&username=david@myownresellercompany.com&passwd=marketleader&name=David&company=DavidCo&address-line-1=96 st&city=Miami&state=FL&country=US&zipcode=55333&phone-cc=186&phone=55151155&lang-pref=en"
      Customer.signup("username" => "david@myownresellercompany.com", "passwd" => "marketleader", "name" => "David", "company" => "DavidCo", "address-line-1" => "96 st", "city" => "Miami", "state" => "FL", "country" => "US", "zipcode" => "55333", "phone-cc" => "186", "phone" => "55151155", "lang-pref" => "en", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for update" do
      org_url = "https://test.httpapi.com/api/customers/modify.json?auth-userid=123456&auth-password=myresellerpass&customer-id=5364&username=david@myownresellercompany.com&name=David&company=DavidCo&lang-pref=en&address-line-1=96 st&city=Miami&state=FL&country=US&zipcode=55333&phone-cc=186&phone=55151155"
      Customer.modify("username" => "david@myownresellercompany.com", "name" => "David", "company" => "DavidCo", "address-line-1" => "96 st", "city" => "Miami", "state" => "FL", "country" => "US", "zipcode" => "55333", "phone-cc" => "186", "phone" => "55151155", "lang-pref" => "en", "customer-id" => "5364", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for get_by_id" do
      org_url = "https://test.httpapi.com/api/customers/details-by-id.json?auth-userid=123456&auth-password=myresellerpass&customer-id=5353"
      Customer.details_by_id("customer_id" => "5353", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for get_by_username" do
      org_url = "https://test.httpapi.com/api/customers/details.json?auth-userid=123456&auth-password=myresellerpass&username=david@myownresellercompany.com"
      Customer.details("username" => "david@myownresellercompany.com", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for change_password" do
      org_url = "https://test.httpapi.com/api/customers/change-password.json?auth-userid=123456&auth-password=myresellerpass&customer-id=8989&new-passwd=password1"
      Customer.change_password("customer_id" => "8989", "new_passwd" => "password1", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for generate_password" do
      org_url = "https://test.httpapi.com/api/customers/temp-password.json?auth-userid=123456&auth-password=myresellerpass&customer-id=8989"
      Customer.temp_password("customer_id" => "8989", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for search" do
      org_url = "https://test.httpapi.com/api/customers/search.json?auth-userid=123456&auth-password=myresellerpass&no-of-records=50&page-no=1&name=David"
      Customer.search("name" => "David", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for delete" do
      org_url = "https://test.httpapi.com/api/customers/delete.json?auth-userid=123456&auth-password=myresellerpass&customer-id=5377"
      Customer.delete("customer_id" => "5377", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for generate_token" do
      org_url = "https://test.httpapi.com/api/customers/generate-token.json?auth-userid=123456&auth-password=myresellerpass&username=david@myownresellercompany.com&passwd=customerpassword&ip=1.1.1.1"
      Customer.generate_token("username"=>"david@myownresellercompany.com","passwd"=>"customerpassword", "ip"=>"1.1.1.1", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for authenticate token" do
      org_url = "https://test.httpapi.com/api/customers/authenticate-token.json?auth-userid=123456&auth-password=myresellerpass&token=generatedtoken"
      Customer.authenticate_token("token" => "generatedtoken", :test_mock => true).should be_eql_url(org_url)
    end
  end

  context "Testing Contact Model" do

    before(:all) do
      ResellerClub::authentication("123456", "myresellerpass")
    end

    it "should generate a correct url for add" do
      org_url = "https://test.httpapi.com/api/contacts/add.json?auth-userid=123456&auth-password=myresellerpass&name=Joe&company=Registrants Inc&email=joe@registrants.com&address-line-1=main st no 41&city=Chicago&country=US&zipcode=11500&phone-cc=202&phone=636518&customer-id=8989245&type=Contact&state=Illinois"
      Contact.add("name" => "Joe", "company" => "Registrants Inc", "email" => "joe@registrants.com", "address-line-1" => "main st no 41", "city" => "Chicago", "state" => "Illinois", "country" => "US", "zipcode" => "11500", "phone-cc" => "202", "phone" => "636518", "customer-id" => "8989245", "type" => "Contact", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify" do
      org_url = "https://test.httpapi.com/api/contacts/modify.json?auth-userid=123456&auth-password=myresellerpass&contact-id=25049249&name=Joe Jr&company=Registrants Inc&email=joe@registrants.com&address-line-1=main st no 41&city=Chicago&country=US&zipcode=11500&phone-cc=202&phone=536585"
      Contact.modify("name" => "Joe Jr", "company" => "Registrants Inc", "email" => "joe@registrants.com", "address-line-1" => "main st no 41", "city" => "Chicago", "country" => "US", "zipcode" => "11500", "phone-cc" => "202", "phone" => "536585", "contact-id" => "25049249", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for details" do
      org_url = "https://test.httpapi.com/api/contacts/details.json?auth-userid=123456&auth-password=myresellerpass&contact-id=25050309"
      Contact.details("contact_id" => "25050309", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for search" do
      org_url = "https://test.httpapi.com/api/contacts/search.json?auth-userid=123456&auth-password=myresellerpass&customer-id=8989245&no-of-records=50&page-no=1&name=Joe Jr"
      Contact.search("name" => "Joe Jr", "customer-id" => "8989245", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for default" do
      org_url = "https://test.httpapi.com/api/contacts/default.json?auth-userid=123456&auth-password=myresellerpass&customer-id=8989245&type=Contact"
      Contact.default("type" => "Contact", "customer-id" => "8989245", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for delete" do
      org_url = "https://test.httpapi.com/api/contacts/delete.json?auth-userid=123456&auth-password=myresellerpass&contact-id=25049249"
      Contact.delete("contact_id" => "25049249", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for set_details" do
      org_url = "https://test.httpapi.com/api/contacts/set-details.json?auth-userid=123456&auth-password=myresellerpass&contact-id=25050309&attr-name1=sponsor1&attr-value1=200&product-key=dotcoop"
      Contact.set_details("contact_id" => "25050309", "product-key" => "dotcoop", "attr-name1" => "sponsor1", "attr-value1" => "200", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for sponsors" do
      org_url = "https://test.httpapi.com/api/contacts/sponsors.json?auth-userid=123456&auth-password=myresellerpass&customer-id=8989245"
      Contact.sponsors("customer_id" => "8989245", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for coop_add_sponsor" do
      org_url = "https://test.httpapi.com/api/contacts/coop/add-sponsor.json?auth-userid=123456&auth-password=myresellerpass&name=Dave&company=Registrants Inc&email=dave@registrants.com&address-line-1=main st no 41&city=Chicago&country=US&zipcode=11500&phone-cc=253&phone=531531&customer-id=8989245"
      Contact.coop_add_sponsor("name" => "Dave", "company" => "Registrants Inc", "email" => "dave@registrants.com", "address-line-1" => "main st no 41", "city" => "Chicago", "country" => "US", "zipcode" => "11500", "phone-cc" => "253", "phone" => "531531", "customer-id" => "8989245", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for dotca_registrantagreement" do
      org_url = "https://test.httpapi.com/api/contacts/dotca/registrantagreement.json?auth-userid=123456&auth-password=myresellerpass"
      Contact.dotca_registrantagreement(:test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for validate_registrant" do
      org_url = "https://test.httpapi.com/api/contacts/validate-registrant.json?auth-userid=123456&auth-password=myresellerpass&contact-id=50309&contact-id=1&eligibility-criteria=CED_ASIAN_COUNTRY&eligibility-criteria=CED_DETAILS"
      Contact.validate_registrant("contact_id" => ["50309", "1"], "eligibility-criteria" => ["CED_ASIAN_COUNTRY", "CED_DETAILS"], :test_mock => true).should be_eql_url(org_url)
    end
  end

  context "Testing Domain Model" do
    before(:all) do
      ResellerClub::authentication("123456", "myresellerpass")
    end

    it "should generate a correct url for available" do
      org_url = "https://test.httpapi.com/api/domains/available.json?auth-userid=123456&auth-password=myresellerpass&domain-name=registrants&tlds=com&tlds=net"
      Domain.available("domain-name" => ["registrants"], "tlds" => ["com", "net"], :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for idn-available" do
      org_url = "https://test.httpapi.com/api/domains/idn-available.json?auth-userid=123456&auth-password=myresellerpass&domain-name=españa&tld=es&idnLanguageCode=es"
      Domain.idn_available("domain-name" => "españa", "tld" => "es", "idnLanguageCode" => "es", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for suggest_names" do
      org_url = "https://test.httpapi.com/api/domains/suggest-names.json?auth-userid=123456&auth-password=myresellerpass&keyword=ipad&tlds=com&tlds=net&no-of-results=5&hyphen-allowed=true&add-related=true"
      Domain.suggest_names("keyword" => "ipad", "tlds" => ["com", "net"], "hyphen-allowed" => "true", "add-related" => "true", "no-of-results" => "5", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for register" do
      org_url = "https://test.httpapi.com/api/domains/register.json?auth-userid=123456&auth-password=myresellerpass&domain-name=domain.asia&years=1&ns=ns1.domain.com&ns=ns2.domain.com&customer-id=8989245&reg-contact-id=25052632&admin-contact-id=25052632&tech-contact-id=25052632&billing-contact-id=25052632&invoice-option=NoInvoice&protect-privacy=true"
      Domain.register("domain-name" => "domain.asia", "years" => "1", "ns" => ["ns1.domain.com", "ns2.domain.com"], "customer_id" => "8989245", "reg-contact-id" => "25052632", "admin-contact-id" => "25052632", "tech-contact-id" => "25052632", "billing-contact-id" => "25052632", "invoice-option" => "NoInvoice", "protect-privacy" => "true", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for register a .COM IDN" do
      org_url = "https://test.httpapi.com/api/domains/register.json?auth-userid=123456&auth-password=myresellerpass&domain-name=ѯҋ112.com&years=1&ns=ns1.domain.com&ns=ns2.domain.com&customer-id=8989245&reg-contact-id=25052632&admin-contact-id=25052632&tech-contact-id=25052632&billing-contact-id=25052632&invoice-option=NoInvoice&protect-privacy=true&attr-name1=idnLanguageCode&attr-value1=aze"
      Domain.register("domain-name" => "ѯҋ112.com", "years" => "1", "ns" => ["ns1.domain.com", "ns2.domain.com"], "customer_id" => "8989245", "reg-contact-id" => "25052632", "admin-contact-id" => "25052632", "tech-contact-id" => "25052632", "billing-contact-id" => "25052632", "invoice-option" => "NoInvoice", "protect-privacy" => "true", "attr-name1" => "idnLanguageCode", "attr-value1" => "aze", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for register a AU Domain" do
      org_url = "https://test.httpapi.com/api/domains/register.json?auth-userid=123456&auth-password=myresellerpass&domain-name=domain.net.au&years=1&ns=ns1.domain.com&ns=ns2.domain.com&customer-id=8989245&reg-contact-id=25052632&admin-contact-id=25052632&tech-contact-id=25052632&billing-contact-id=25052632&invoice-option=NoInvoice&protect-privacy=true&attr-name1=id-type&attr-value1=ACN&attr-name2=id&attr-value2=079 009 340&attr-name3=policyReason&attr-value3=1&attr-name4=isAUWarranty&attr-value4=true"
      Domain.register("domain-name" => "domain.net.au", "years" => "1", "ns" => ["ns1.domain.com", "ns2.domain.com"], "customer_id" => "8989245", "reg-contact-id" => "25052632", "admin-contact-id" => "25052632", "tech-contact-id" => "25052632", "billing-contact-id" => "25052632", "invoice-option" => "NoInvoice", "protect-privacy" => "true", "attr-name1" => "id-type", "attr-value1" => "ACN", "attr-name2" => "id", "attr-value2" => "079 009 340", "attr-name3" => "policyReason", "attr-value3" => "1", "attr-name4" => "isAUWarranty", "attr-value4" => "true", :test_mock => true).should be_eql_url(org_url)
    end


    it "should generate a correct url for validate_transfer" do
      org_url = "https://test.httpapi.com/api/domains/validate-transfer.json?auth-userid=123456&auth-password=myresellerpass&domain-name=google.com"
      Domain.validate_transfer("domain_name" => "google.com", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for transfer" do
      org_url = "https://test.httpapi.com/api/domains/transfer.json?auth-userid=123456&auth-password=myresellerpass&domain-name=newdomain.asia&auth-code=auth-code&ns=ns1.domain.com&ns=ns2.domain.com&customer-id=3265463&reg-contact-id=5243658&admin-contact-id=63532223&tech-contact-id=67543261&billing-contact-id=42165314&invoice-option=KeepInvoice&protect-privacy=false&attr-name1=cedcontactid&attr-value1=0"
      Domain.transfer("domain-name" => "newdomain.asia", "auth-code" => "auth-code", "ns" => ["ns1.domain.com", "ns2.domain.com"], "customer-id" => "3265463", "reg-contact-id" => "5243658", "admin-contact-id" => "63532223", "tech-contact-id" => "67543261", "billing-contact-id" => "42165314", "invoice-option" => "KeepInvoice", "protect-privacy" => "false", "attr-name1" => "cedcontactid", "attr-value1" => "0", :test_mock => true).should be_eql_url(org_url)
    end

    # it "should generate a correct url for transfer_eu" do
    #   org_url = ""
    #   Domain.transfer_eu("domain-name" => "myeudomain.eu", "customer-id" => "6463465", "invoice-option" => "NoInvoice", "ns" => ["ns1.domain.org", "ns2.domain.org"], "cns1" => "ns1.domain.eu", "ip1" => "0.0.0.0,1.1.1.1", "cns2" => "ns2.domain.eu", "ip2" => "0.0.0.0,1.1.1.1").should be_eql_url(org_url)
    # end

    # it "should generate a correct url for trade" do
    #   org_url = ""
    #   Domain.trade("domain-name" => "domain.eu", "customer-id" => "53142", "invoice-option" => "NoInvoice", "ns" => ["ns1.domain.org", "ns2.domain.org"], "cns1" => "ns1.domain.eu", "ip1" => "0.0.0.0,1.1.1.1", "cns2" => "ns2.domain.eu", "ip2" => "0.0.0.0,1.1.1.1", "reg-contact-id" => "0").should be_eql_url(org_url)
    # end

    it "should generate a correct url for renew" do
      org_url = "https://test.httpapi.com/api/domains/renew.json?auth-userid=123456&auth-password=myresellerpass&order-id=46983636&years=1&exp-date=1353825293&invoice-option=NoInvoice"
      Domain.renew("order-id" => "46983636", "years" => "1", "exp-date" => "1353825293", "invoice-option" => "NoInvoice", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for search" do
      org_url = "https://test.httpapi.com/api/domains/search.json?auth-userid=123456&auth-password=myresellerpass&no-of-records=10&page-no=1&domain-name=registrants.com"
      Domain.search("domain-name" => "registrants.com", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for customer_default_ns" do
      org_url = "https://test.httpapi.com/api/domains/customer-default-ns.json?auth-userid=123456&auth-password=myresellerpass&customer-id=111"
      Domain.customer_default_ns("customer_id" => "111", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for orderid" do
      org_url = "https://test.httpapi.com/api/domains/orderid.json?auth-userid=123456&auth-password=myresellerpass&domain-name=domain.com"
      Domain.orderid("domain-name" => "domain.com", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for details" do
      org_url = "https://test.httpapi.com/api/domains/details.json?auth-userid=123456&auth-password=myresellerpass&order-id=300&options=OrderDetails"
      Domain.details("order-id" => "300", "options" => "OrderDetails", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_ns" do
      org_url = "https://test.httpapi.com/api/domains/modify-ns.json?auth-userid=123456&auth-password=myresellerpass&order-id=111&ns=ns1.domain.asia&ns=ns2.domain.asia"
      Domain.modify_ns("order-id" => "111", "ns" => ["ns1.domain.asia", "ns2.domain.asia"], :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for add_cns" do
      org_url = "https://test.httpapi.com/api/domains/add-cns.json?auth-userid=123456&auth-password=myresellerpass&order-id=111&cns=ns1.domain.com&ip=0.0.0.0&ip=1.1.1.1"
      Domain.add_cns("order-id" => "111", "cns" => "ns1.domain.com", "ip" => ["0.0.0.0", "1.1.1.1"], :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_cns_name" do
      org_url = "https://test.httpapi.com/api/domains/modify-cns-name.json?auth-userid=123456&auth-password=myresellerpass&order-id=555&old-cns=ns1.domain.com&new-cns=ns2.domain.com"
      Domain.modify_cns_name("order-id" => "555", "old-cns" => "ns1.domain.com", "new-cns" => "ns2.domain.com", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_cns_ip" do
      org_url = "https://test.httpapi.com/api/domains/modify-cns-ip.json?auth-userid=123456&auth-password=myresellerpass&order-id=777&cns=ns1.domain.com&old-ip=0.0.0.0&new-ip=1.1.1.1"
      Domain.modify_cns_ip("order-id" => "777", "cns" => "ns1.domain.com", "old-ip" => "0.0.0.0", "new-ip" => "1.1.1.1", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for enable_theft_protection" do
      org_url = "https://test.httpapi.com/api/domains/enable-theft-protection.json?auth-userid=123456&auth-password=myresellerpass&order-id=51"
      Domain.enable_theft_protection("order-id" => "51", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for delete_cns_ip" do
      org_url = "https://test.httpapi.com/api/domains/delete-cns-ip.json?auth-userid=123456&auth-password=myresellerpass&order-id=531&cns=ns1.domain.asia&ip=1.2.3.4"
      Domain.delete_cns_ip("order-id" => "531", "cns" => "ns1.domain.asia", "ip" => "1.2.3.4", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_contact" do
      org_url = "https://test.httpapi.com/api/domains/modify-contact.json?auth-userid=123456&auth-password=myresellerpass&order-id=753&reg-contact-id=1645316&admin-contact-id=53146&tech-contact-id=8361166&billing-contact-id=6146"
      Domain.modify_contact("order-id" => "753", "reg-contact-id" => "1645316", "admin-contact-id" => "53146", "tech-contact-id" => "8361166", "billing-contact-id" => "6146", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_privacy_protection" do
      org_url = "https://test.httpapi.com/api/domains/modify-privacy-protection.json?auth-userid=123456&auth-password=myresellerpass&order-id=42323&protect-privacy=true&reason=somereason"
      Domain.modify_privacy_protection("order-id" => "42323", "protect-privacy" => "true", "reason" => "somereason", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for modify_auth_code" do
      org_url = "https://test.httpapi.com/api/domains/modify-auth-code.json?auth-userid=123456&auth-password=myresellerpass&order-id=564&auth-code=authcode"
      Domain.modify_auth_code("order-id" => "564", "auth-code" => "authcode", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for disable_theft_protection" do
      org_url = "https://test.httpapi.com/api/domains/disable-theft-protection.json?auth-userid=123456&auth-password=myresellerpass&order-id=53"
      Domain.disable_theft_protection("order-id" => "53", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for locks" do
      org_url = "https://test.httpapi.com/api/domains/locks.json?auth-userid=123456&auth-password=myresellerpass&order-id=65"
      Domain.locks("order-id" => "65", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for tel_cth_details" do
      org_url = "https://test.httpapi.com/api/domains/tel/cth-details.json?auth-userid=123456&auth-password=myresellerpass&order-id=65"
      Domain.tel_cth_details("order-id" => "65", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for tel_modify_whois_pref" do
      org_url = "https://test.httpapi.com/api/domains/tel/modify-whois-pref.json?auth-userid=123456&auth-password=myresellerpass&order-id=573&whois-type=Legal&publish=y"
      Domain.tel_modify_whois_pref("order-id" => "573", "whois-type" => "Legal", "publish" => "y", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for resend_rfa" do
      org_url = "https://test.httpapi.com/api/domains/resend-rfa.json?auth-userid=123456&auth-password=myresellerpass&order-id=65"
      Domain.resend_rfa("order-id" => "65", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for uk_release" do
      org_url = "https://test.httpapi.com/api/domains/uk/release.json?auth-userid=123456&auth-password=myresellerpass&order-id=5357&new-tag=newregistrartag"
      Domain.uk_release("order-id" => "5357", "new-tag" => "newregistrartag", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for cancel_transfer" do
      org_url = "https://test.httpapi.com/api/domains/cancel-transfer.json?auth-userid=123456&auth-password=myresellerpass&order-id=536"
      Domain.cancel_transfer("order-id" => "536", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for delete" do
      org_url = "https://test.httpapi.com/api/domains/delete.json?auth-userid=123456&auth-password=myresellerpass&order-id=536"
      Domain.delete("order-id" => "536", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for restore" do
      org_url = "https://test.httpapi.com/api/domains/restore.json?auth-userid=123456&auth-password=myresellerpass&order-id=560&invoice-option=KeepInvoice"
      Domain.restore("order-id" => "560", "invoice-option" => "KeepInvoice", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for de_recheck_ns" do
      org_url = "https://test.httpapi.com/api/domains/de/recheck-ns.json?auth-userid=123456&auth-password=myresellerpass&order-id=568"
      Domain.de_recheck_ns("order-id" => "568", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for dotxxx_association_details" do
      org_url = "https://test.httpapi.com/api/domains/dotxxx/association-details.json?auth-userid=123456&auth-password=myresellerpass&order-id=123&association-id=123"
      Domain.dotxxx_association_details("order-id" => "123", "association-id" => "123", :test_mock => true).should be_eql_url(org_url)
    end

  end

  context "Testing Order Model" do

    before(:all) do
      ResellerClub::authentication("123456", "myresellerpass")
    end

    it "should generate a correct url for suspend" do
      org_url = "https://test.httpapi.com/api/orders/suspend.json?auth-userid=123456&auth-password=myresellerpass&order-id=31&reason=reason-for-suspension"
      Order.suspend("order-id" => "31", "reason" => "reason-for-suspension", :test_mock => true).should be_eql_url(org_url)
    end

    it "should generate a correct url for unsuspend" do
      org_url = "https://test.httpapi.com/api/orders/unsuspend.json?auth-userid=123456&auth-password=myresellerpass&order-id=31"
      Order.unsuspend("order-id" => "31", :test_mock => true).should be_eql_url(org_url)
    end

  end

  # context "Testing Reseller Model" do

  #   before(:all) do
  #     ResellerClub::authentication("123456", "myresellerpass")
  #   end

  #   it "should generate a correct url for add" do
  #     org_url = ""
  #     Reseller.signup("username" => "thomas@reseller.com","passwd" => "shoemaker","name" => "Thomas", "address_line_1" => "5ft avenue #253", "company" => "Reseller Inc.", "city" => "NYC", "state" => "NY", "country" => "CU", "zipcode" => "12345655", "phone_cc" => "011", "phone" => "531531","accounting_currency_symbol" => "USD", "selling_currency_symbol" => "USD", "sales_contact_id" => "531", :test_mock => true).should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for update" do
  #     org_url = ""
  #     Reseller.modify("username" => "sergei@google.com","passwd" => "brin", "name" => "Serguei Brin","address_line_1" => "Silicon Valley #53", "company" => "Google Inc.", "city" => "Silicon Valley", "state" => "California", "country" => "US", "zipcode" => "123456", "phone_cc" => "531", "phone" => "531531","reseller_id"=> "433154", "accounting_currency_symbol" => "USD", "selling_currency_symbol" => "USD", "website_url" => "http://www.google.com").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for get_details" do
  #     org_url = ""
  #     Reseller.get_details("433154").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for generate_password" do
  #     org_url = ""
  #     Reseller.generate_password("433154").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for search" do
  #     org_url = ""
  #     Reseller.search("name" => "Tyler").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for generate_token" do
  #     org_url = ""
  #     Reseller.generate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "ip" => "69.63.139.34").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for authenticate_token" do
  #     org_url = ""
  #     Reseller.authenticate_token("auth_userid" => "433154", "auth_password" => "lV6UAIxi", "token" => "token").should be_eql_url(org_url)
  #   end

  #   it "should generate a correct url for promo_prices" do
  #     org_url = ""
  #     Reseller.promo_prices("auth_userid" => "433154", "auth_password" => "lV6UAIxi").should be_eql_url(org_url)
  #   end
  # end

end
