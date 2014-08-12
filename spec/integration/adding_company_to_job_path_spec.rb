RSpec.describe "adding company to job", :integration do

  context "add a company to a job" do
    let!(:company){ Company.create(name: "Company")}
    let!(:job){ Job.create(name: "Programmer")}
    let(:output){run_networker_with_input("3", "v", "1", "c", "1")}

    it "should add a company to the job" do
      expect(output).to include ("Company")
      job.reload
      expect(job.company_id).to eql 1
    end
  end

end
