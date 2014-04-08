class Directory::User

  attr_accessor :username


  def initialize(username=nil)
    @username = username
  end


  def admin?
    ['rmalott', 'rfox2', 'jhartzle', 'fboze', 'adixon4', 'msimons', 'mstenber', 'mwolff'].include?(self.username)
  end

end

