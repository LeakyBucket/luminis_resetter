module Resetter
  module Routes
    get '/' do
      erb :index
    end
  
    post '/reset' do
      username = params[:username].downcase
      
      unless Resetter::FORBIDDEN_USERS.include? username
        connect
        reset_password(username)
      else
        @bad_user = true
      end
      
      erb :reset
    end
  end
end