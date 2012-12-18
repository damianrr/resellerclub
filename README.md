This gem it's unstable, unfinished and mostly in alpha stage. You have been warn!!!

This gem implements some sections of the ResellerClub (http://www.resellerclub.com) API. This sections are specifically: Customers, Resellers, Contacts and Domains.

Method names:
To keep consistency with the API and also with the purpose of reusing the documentation of ResellerClub, all method names are drawn from their HTTP counterparts following a simple process.
 We use a "base url" for each of the models and each action has it's own "url action"; this "url action" is processed to build the method name like this: The first thing we do is remove the .json/xml termination, (so that de/recheck-ns.json transforms into de/recheck-ns ) next when action has subpaths (like in de/recheck-ns) we substitute the "/" character for "_" (so de/recheck-ns converts to de_recheck-ns) and finally we convert all "-" characters to "_" (de_recheck-ns turns into de_recheck_ns) thus getting to a valid method name in Ruby. So in resume, you take the "action url", remove the .json/xml termination, and substitute all "/" and "-" for "_" and you have the method name for that HTTP action.

The "base urls" are:
 - For Customer: https://test.httpapi.com/api/customers/
 - For Domain: https://test.httpapi.com/api/domains/
 - For Reseller: https://test.httpapi.com/api/customers/
 - For Order: https://test.httpapi.com/api/orders/
 - For Contact: https://test.httpapi.com/api/contacts/

Arguments:
(The words parameter/s and argument/s are used interchangeably)

There are some arguments in some of the ResellerClub HTTP API that are mandatory however, we provide a default to ease the programmer's task thus allowing him/her to omit this parameter in the hash provided to the method call, those are the cases of: "lang-pref" defaulting to "en", "no-of-records" defaulting to 50, and page-no defaulting to 1, if the parameter is provided in the hash it will overwrite the default.
There are 2 more parameter that the programmer will not need to provide an those are "auth_userid", and "auth_password" this will be taken from the initial configuration required to use this module. (Note that the real names of the parameters in the ResellerClub HTTP API are "auth-userid", "auth_password", either version will work with this gem)

All methods take their parameters by name.

All parameters need to be strings (no integers, no booleans, true is "true", and 513 is "513").

All parameter names should be equivalent to those documented in the ResellerClub HTTP API Documentation (http://cp.onlyfordemo.net/kb/answer/744), aside from this there is an special parameter used in this gem for testing purposes that is named "test_mock", if "test_mock" => true is provided in the argument hash there will be no HTTP Request made to ResellerClub instead the method will return the corresponding address,

If, excepting those arguments mentioned above, the method only take one remaining argument it can be passed directly. For example:
This function can be invoked in either of this ways:
Contact.details("contact_id" => "25050309")

Contact.details("25050309")

Authentication:
To use this gem one needs to provide a valid authentication and it's done this way:

ResellerClub::authentication("31531", "pass")

where 31531 is a valid registered userid and pass the user's password

Examples of Use:
Refer to the test/basic.rb for examples

Other Documentation:
All methods, and parameters correspond to their counterparts in ResellerClub HTTP API so, for more information refer to the ResellerClub HTTP API Documentation (http://cp.onlyfordemo.net/kb/answer/744)

Drawbacks:
Once you set the authentication it cannot be changed, for example:
This will work with the newly setted up auth:

ResellerClub::authentication("5311", "pass")

ResellerClub::authentication("4354", "newpass")

puts Customer.search("name" => "David", :test_mock => true)

This won't work:
ResellerClub::authentication("5311", "pass")

puts Customer.search("name" => "David", :test_mock => true)

ResellerClub::authentication("4354", "newpass")

puts Customer.search("name" => "David", :test_mock => true)

Here both times it will be used the old authentication
