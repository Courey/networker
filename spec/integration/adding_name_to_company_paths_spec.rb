RSpec.describe "Adding companies", :integration do
  context "selecting the option to add a company" do
    let!(:output){ run_networker_with_input("1", "a") }
    it "should select the add a company option and prompt to add company name" do
      expect(output).to include("Please enter a company name:")
    end
  end
  context "adding a company" do
    let!(:output){ run_networker_with_input("1", "a", "Company Name") }
    it "should add a company" do
      expect(Company.count).to eql 1
    end
    it "should save the record accurately" do
      expect(Company.last.name).to eql "Company Name"
    end
  end
  context "with invalid input" do
    let(:long_string){ "foo" * 12 }
    let!(:output){ run_networker_with_input("1", "a", long_string) }

    it "prints the error message for the type of invalid input" do
      expect(output).to include("Name must be less than 30 characters")
    end
    it "shouldn't save the new record" do
      expect(Company.count).to eql 0
    end
  end
end
