RSpec.describe "Viewing companies", :integration do
  let!(:company1){ Company.create(name: "First") }
  let!(:company2){ Company.create(name: "Second") }

  context "viewing all companies" do
    let(:output){ run_networker_with_input('1', "v") }
    it "should list all companies" do
      expect(output).to include("1. First\n2. Second")
    end
  end

  context "viewing individual company" do
    let(:output){ run_networker_with_input('1', "v", "1") }
    it "should Show one company" do
      expect(output).to include("==========\nFirst\n==========\nType 'a' to add description.")
    end
  end

  context "if we enter a company that doesn't exist" do
    let(:output){ run_networker_with_input('1', "v", "3") }
    it "prints an error message" do
      expect(output).to include("Sorry, company 3 doesn't exist.")
    end
  end

  # add a test for viewing a company with a description
end
