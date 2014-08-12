RSpec.describe "Networker Main Menu" do
  context "Prints a menu" do
    it "shows header" do
      actual = run_networker_with_input()
      expected = %q{
==========
Networker
==========
}
      expect(actual).to include(expected)
    end

    it "shows four options" do
      actual = run_networker_with_input()
      expected = "1. Companies\n2. Contacts\n3. Jobs\n4. Search\n5. Press 'q' to quit"
      expect(actual).to include(expected)
    end
  end
  context "when we type an incorrect command" do
    let(:output) { run_networker_with_input('mmmmq')}
    it "prints out an informative error message" do
      expect(output).to include("'mmmmq' is not a valid option.")
    end
  end

  context "when we type a correct command" do
    let(:output) { run_networker_with_input('1')}
    it "should print the path header" do
      expect(output).to include("==========\nCompanies\n==========")
    end
  end
end
