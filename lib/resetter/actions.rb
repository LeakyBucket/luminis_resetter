module Resetter
  module Actions
    def connect
      @ldap = Net::LDAP.new :host => Resetter::LUMINIS, :port => 389, :base => "ou=People,o=cnm.edu,o=cp", :auth => { :method => :simple, :username => Resetter::ADMIN, :password => Resetter::PASSWORD }
    end
    
    def user_filter(username)
      Net::LDAP::Filter.eq("uid", Net::LDAP::Filter.escape(username))
    end
    
    def get_user(username)
      @ldap.search(:filter => user_filter(username)).first
    end
    
    def generate_string
      characters = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
      
      (0..14).map { characters[rand(characters.length)] }.join
    end
    
    def reset_password(username)
      ops = [
        [:replace, :userPassword, Net::LDAP::Password.generate(:sha, generate_string)]
      ]
      
      @ldap.modify :dn => get_user(username).dn, :operations => ops
    end
    
    def expire_password(username)
      
    end
  end # Actions module
end