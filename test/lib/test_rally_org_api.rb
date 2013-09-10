require 'test_helper'

describe RallyOrgApi do
  it "exists" do
    described_class.should_not be_nil
  end

  describe ".config" do
    it "yields to block, passing self" do
      described_class.config { |r| print r }.should_output "RallyOrgApi"
    end
  end
end
