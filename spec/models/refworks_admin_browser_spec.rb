require 'spec_helper'

describe "Refworks Connection Test", :connects_to_refworks => true do
=begin
  it "should not log in with an incorrect password" do
    browser = RefworksAdminBrowser.new
    browser.logged_in?.should be_false
    browser.log_in!(nil, 'foo')
    browser.logged_in?.should be_false
  end

  it "accesses the admin and downloads a parseable user list" do
    browser = RefworksAdminBrowser.new
    browser.logged_in?.should be_false
    browser.log_in!
    browser.logged_in?.should be_true
    
    raw_users = browser.get_user_list(3)
    parsed_users = RefworksCache.parse_raw_users(raw_users)
    parsed_users.should be_a_kind_of(Array)
    parsed_users.size.should >= 0
  end
=end
#=begin  
  it "resets the password for the refworkstest user" do
    admin_browser = RefworksAdminBrowser.new
    public_browser = RefworksPublicBrowser.new
    test_login = 'ndrefworkstest'
    test_password = 'newpassword'
    user = RefworksCache.find_by_login(test_login)
    if user.nil?
      puts "Fetching full user list from Refworks"
      raw_users = admin_browser.get_user_list(7)
      puts "Done fetching user list"
      parsed_users = RefworksCache.parse_raw_users(raw_users)
      p parsed_users
      user_data = parsed_users.detect{|u| u[:login] == test_login}
      p user_data
      user = RefworksCache.new(user_data)
      user.valid?.should be_true
      user.save!
    end
    user.should be_a_kind_of(RefworksCache)
    
    admin_browser.reset_password_for(user)
    public_browser.login_as(user.login, test_password)
    public_browser.logged_in?.should be_false
    
    public_browser.login_as(user.login, user.temporary_password)
    public_browser.logged_in?.should be_true
    
    public_browser.change_password_to(test_password)
    new_public_browser = RefworksPublicBrowser.new
    new_public_browser.login_as(user.login, test_password)
    public_browser.logged_in?.should be_true
  end
#=end
end
