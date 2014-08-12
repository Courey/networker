RSpec.describe "Viewing contacts", :integration do
  let!(:contact1){ Contact.create(first_name: "First", last_name: "Last") }
  let!(:contact2){ Contact.create(first_name: "Second", last_name: "Name") }

  context "viewing all contacts" do
    let(:output){ run_networker_with_input('2', "v") }
    it "should list all contacts" do
      expect(output).to include("1. First Last\n2. Second Name")
    end
  end

  context "viewing individual contact" do
    let(:output){ run_networker_with_input('2', "v", "1") }
    it "should Show one contact" do
      expect(output).to include("==========\nFirst Last\n==========\nType 'd' to add description.")
    end
  end

  context "if we enter a contact that doesn't exist" do
    let(:output){ run_networker_with_input('2', "v", "3") }
    it "prints an error message" do
      expect(output).to include("Sorry, contact 3 doesn't exist.")
    end
  end

  # add a test for viewing a company with a description
end
