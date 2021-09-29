require 'station'

describe Station do

  subject { Station.new("London Bridge", 1) }

  describe '#initialize' do

    it "knows its name" do
      expect(subject.name).to eq "London Bridge"
    end

    it "knows its zone" do
      expect(subject.zone).to eq 1
    end

  end

end