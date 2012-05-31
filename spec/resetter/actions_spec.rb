require 'spec_helper'

describe "Resetter::Actions" do
  let (:clean_room) { class TestSlate < Object; include ::Resetter::Actions; end }
  let (:actions) { clean_room.new }
  
  describe "#reset_password" do
    let (:ops) { [[:replace, :userPassword, "OscarHatesMe"]]}
    
    it "changes the user\'s LDAP password" do
      mock_ldap = double('Net::LDAP')
      mock_entry = double('Net::LDAP::Entry')
      mock_ldap.stub(:search).and_return(mock_entry)
      mock_entry.stub(:dn).and_return("uid=lholcomb2,ou=People,o=cnm.edu,o=cp")
      actions.instance_eval { @ldap = mock_ldap }
      actions.reset_password("lholcomb2")
      
      mock_ldap.should_receive(:modify).with({:dn => actions.instance_eval { get_user("lholcomb2").dn }, :operations => ops})
    end
  end
  
  describe "#generate_string" do
    it "generates a random string 15 characters long" do
      ran_str = actions.generate_string
      new_ran = actions.generate_string
      
      ran_str.should_not == new_ran
      ran_str.length.should be(15)
    end
  end
  
  describe "#user_filter" do
    it "creates a Net::LDAP filter for the target user" do
      actions.user_filter("lholcomb2").should be_a(Net::LDAP::Filter)
    end
  end
  
  describe "#log" do
    it "creates a log entry"
  end
  
  describe "#connect" do
    it "connects to the Luminis LDAP" do
      actions.connect
      
      actions.instance_eval { @ldap }.should be_a(Net::LDAP)
    end
  end
end