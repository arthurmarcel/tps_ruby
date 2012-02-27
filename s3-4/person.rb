require 'digest/sha1'

class Person
   attr_accessor :first_name, :last_name, :id
   attr_reader :password

  def initialize
    @first_name = @last_name = @id = ""
  end

  def valid?
    not (last_name.nil?|| last_name.empty? || first_name.nil? || first_name.empty? || id.nil? || id.empty?)
  end

  def password=(clear_text)
    @password = Digest::SHA1.hexdigest(clear_text)
  end

  def authenticate(clear_text)
    Digest::SHA1.hexdigest(clear_text) == password
  end

end
