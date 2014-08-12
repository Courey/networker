RSpec.describe "job path controller", :integration do

  context "add a description to a job" do
    let!(:job){ Job.create(name: "Programmer")}
    let(:output){run_networker_with_input("3", "v", "1", "d", "this is a description")}

    it "should add a description to the job" do
      expect(output).to include ("this is a description")
      job.reload
      expect(job.description).to eql "this is a description"
    end
  end

  context "add requirements to a job" do
    let!(:job){ Job.create(name: "Job")}
    let(:output){run_networker_with_input("3", "v", "1", "r", "this is a requirement")}

    it "should add requirements to the job" do
      expect(output).to include ("this is a requirement")
      job.reload
      expect(job.requirements).to eql "this is a requirement"
    end
  end



end
