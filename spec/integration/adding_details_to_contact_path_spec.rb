RSpec.describe "adding description to contact", :integration do


  context "add a description to a contact" do
    let!(:contact){ Contact.create(first_name: "Steve", last_name: "Stevens")}
    let(:output){run_networker_with_input("2", "v", "1", "d", "this is a description")}

    it "should add a description to the contact" do
      expect(output).to include ("this is a description")
      contact.reload
      expect(contact.description).to eql "this is a description"
    end
  end

  context "add title to a contact" do
    let!(:contact){ Contact.create(first_name: "Steve", last_name: "Stevens")}
    let(:output){run_networker_with_input("2", "v", "1", "t", "this is a title")}

    it "should add a description to the contact" do
      expect(output).to include ("this is a title")
      contact.reload
      expect(contact.title).to eql "this is a title"
    end
  end
  context "add phone to a contact" do
    let!(:contact){ Contact.create(first_name: "Steve", last_name: "Stevens")}
    let(:output){run_networker_with_input("2", "v", "1", "p", "0001112222")}

    it "should add a phone number to the contact" do
      expect(output).to include ("0001112222")
      contact.reload
      expect(contact.phone).to eql "0001112222"
    end
  end
  context "add email to a contact" do
    let!(:contact){ Contact.create(first_name: "Steve", last_name: "Stevens")}
    let(:output){run_networker_with_input("2", "v", "1", "e", "steve@steve.com")}

    it "should add an email address to the contact" do
      expect(output).to include ("steve@steve.com")
      contact.reload
      expect(contact.email).to eql "steve@steve.com"
    end
  end
end
