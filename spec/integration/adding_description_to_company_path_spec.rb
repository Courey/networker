RSpec.describe "adding description to company", :integration do

  context "add a description to a company" do
    let!(:company){ Company.create(name: "Company")}
    let(:output){run_networker_with_input("1", "v", "1", "a", "this is a description")}

    it "should add a description to the company" do
      expect(output).to include ("this is a description")
      company.reload
      expect(company.description).to eql "this is a description"
    end
  end

end
