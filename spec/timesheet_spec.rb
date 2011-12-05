require 'spec_helper'

describe Timesheet do #class methods
  subject { Timesheet } 
  
  let(:reader) { mock("reader").tap { |r| r.stub!(:open) } }
  let(:invalid_reader) { mock("invalid reader") }

  it { should respond_to :entry }
  describe "#entry" do
    it "should take a username and a tick-type as an argument to .entry" do
      expect { subject.entry('test_user', :in, reader) }.should_not raise_error
      expect { subject.entry('test_user', :out, reader) }.should_not raise_error
    end

    it "optionally expects a dependency which responds to #open" do
      expect { subject.entry('test', :in, reader) }.should_not raise_error
      expect { subject.entry('test', :in, invalid_reader) }.should raise_error
    end
  end

  describe "#clock" do
    it "should write the tick to the user's timesheet" do
      reader.should_receive(:open).with(PERCIVAL_ROOT + '/data/timesheets/test', 'w')

      subject.entry('test', :in, reader)
    end
  end
  
end

