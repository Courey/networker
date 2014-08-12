RSpec.describe "Viewing jobs", :integration do
  let!(:job1){ Job.create(name: "First") }
  let!(:job2){ Job.create(name: "Second") }

  context "viewing all jobs" do
    let(:output){ run_networker_with_input('3', "v") }
    it "should list all jobs" do
      expect(output).to include("1. First\n2. Second")
    end
  end

  context "viewing individual job" do
    let(:output){ run_networker_with_input('3', "v", "1") }
    it "should Show one job" do
      expect(output).to include("==========\nFirst\n==========\n")
    end
  end

  context "if we enter a job that doesn't exist" do
    let(:output){ run_networker_with_input('3', "v", "3") }
    it "prints an error message" do
      expect(output).to include("Sorry, job 3 doesn't exist.")
    end
  end

  # add a test for viewing a company with a description
end
