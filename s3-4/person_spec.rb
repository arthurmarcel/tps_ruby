$:.unshift File.dirname(__FILE__)
# $: tableau contenant les répertoires où on cherche les fichiers en appelant require
# __FILE__ : le nom du fichier courant
# File.dirname(...) : le nom du répertoire hébergeant le fichier
# File.join : construit un chemin d'accès à un fichier en concaténant les éléments passés

require 'person'

describe Person do
  context "when created" do
    its(:last_name) {should be_empty}
    its(:first_name) {should be_empty}
    its(:id) {should be_empty}
  end

  describe "validation" do
    before(:each) do
      @person = Person.new
      @person.last_name = "toto"
      @person.first_name = "titi"
      @person.id = "tata"
    end
    context "whith a first_name, a last_name and a id" do
      it "should be valid" do
        @person.should be_valid
      end
    end
    ["last_name", "first_name", "id"].each do |attr|
      context "without a #{attr}" do
        it "should not be valid" do
          @person.send("#{attr}=", nil)
          @person.should_not be_valid
        end
      end
      context "with an empty #{attr}" do
        it "should not be valid" do
          @person.send("#{attr}=", "")
          @person.should_not be_valid
        end
      end
    end
  end

  it "should encrypt the password with sha1" do
    Digest::SHA1.should_receive(:hexdigest).with("foo").and_return("0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33")
    subject.password="foo"
  end

  it "should store the sha1 digest" do
    subject.password="foo"
    subject.password.should == "0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33"
  end

  describe "user authentication" do
    it "should crypt the clear password given" do
      Digest::SHA1.should_receive(:hexdigest).with("foo").and_return("0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33")
      subject.authenticate("foo")
    end

    describe "authentication with password challenge" do
      subject{ p = Person.new; p.password = "foo"; p}
      context "correct password" do
        it "should return valid authentication" do
          subject.authenticate("foo").should be_true
        end
      end

      context "incorrect password" do
        it "should return invalid authentication" do
          subject.authenticate("bad pass").should be_false
        end
      end
    end
  end
end
