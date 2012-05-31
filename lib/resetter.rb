require 'sinatra'
require 'net/ldap'
require 'resetter/routes'
require 'resetter/actions'

module Resetter
  FORBIDDEN_USERS = [
                      "lumadmin",
                      "faculty-lo",
                      "student-lo",
                      "allusers-lo",
                      "employee-lo",
                      "groupstudiosystemuser",
                      "targetedannouncementsystemuser",
                      "system",
                      "portadmin",
                      "adminport",
                      "usertemplate",
                      "fragmenttemplate",
                      "ravealerts",
                      "dlmf_25",
                      "usertemplate"
  ]
end

class PasswordResetter < Sinatra::Application
  include Resetter::Routes
  include Resetter::Actions
end