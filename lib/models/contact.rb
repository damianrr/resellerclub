# -*- coding: utf-8 -*-
require_relative '../decorators.rb'

class Contact

  extend DecorateResellerClubModels

  def
  end
values = {
"auth-userid" => "", # Integer Authentication Parameter
"auth-password" => "", # String Required Authentication Parameter
"name" => "", # String Required Name of the contact.
"company" => "", # String Required Name of the company Note Optional in case of EuContact
"email" => "", # String Required Email address of the contact.
"address-line-1" => "", # String Required First line of address of the contact..
"city" => "", # String Required Name of the City.
"country" => "", # String Required Country Code as per ISO 3166-1 alpha-2.
"zipcode" => "", # String Required ZIP code.
"phone-cc" => "", # String Required Telephone number country code.
"phone" => "", # String Required Telephone number
"customer-id" => "", # Integer Required The customer under whom you want to create the contact.
"type" => "", # String Required The contact type. This can take following values:Contact, CoopContact, UkContact, EuContact, CnContact, CoContact, CaContact, DeContact, EsContact
"address-line-2" => "", # String Optional Second line of address of the contact.
"address-line-3" => "", # String Optional Third line of address of the contact..
"state" => "", # String Optional Name of the state. For EsContact contact type, mention one of the following provinces: Albacete, Alicante, Almeria, Araba, Asturias, Avila, Badajoz, Barcelona, Bizkaia, Burgos, Caceres, Cadiz, Cantabria, Castellon, Ceuta, Ciudad Real, Cordoba, Coruña, A, Cuenca, Gipuzkoa, Girona, Granada, Guadalajara, Huelva, Huesca, Illes Balears, Jaen, Leon, Lleida, Lugo, Madrid, Malaga, Melilla, Murcia, Navarra, Ourense, Palencia, Palmas, Las, Pontevedra, Rioja, La, Salamanca, Santa Cruz de Tenerife, Segovia, Sevilla, Soria, Tarragona, Teruel, Toledo, Valencia, Valladolid, Zamora, Zaragoza
"fax-cc" => "", # String Optional Fax number country code.
"fax" => "", # String Optional Fax number.
}

end
