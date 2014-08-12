RSpec.describe "Adding contacts", :integration do
  context "selecting the option to add a contact" do
    let!(:output){ run_networker_with_input("2", "a") }
    it "should select the add a contact option and prompt to add contact name" do
      expect(output).to include("Please enter contact's first name:")
    end
  end
  context "adding a company" do
    let!(:output){ run_networker_with_input("2", "a", "Steve", "Stevens") }
    it "should add a contact" do
      expect(Contact.count).to eql 1
    end
    it "should save the record accurately" do
      expect(Contact.last.first_name).to eql "Steve"
      expect(Contact.last.last_name).to eql "Stevens"
    end
  end
  context "with invalid input" do
    let(:long_string){ "foo" * 12 }
    let!(:output){ run_networker_with_input("2", "a", long_string, long_string) }

    it "prints the error message for the type of invalid input" do
      expect(output).to include("First name must be less than 30 characters")
    end
    it "shouldn't save the new record" do
      expect(Contact.count).to eql 0
    end
  end
end
