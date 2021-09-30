require 'journey'

describe Journey do

  # let(:station) { double :station, zone: 1 }
  let(:penalty_fare) { Journey::PENALTY_FARE }
  
    it "creates journey with an entry station" do
      expect(subject.start).to eq @entry_station
    end

    it "knows if a journey is not complete" do
      expect(subject.complete?).to eq true
    end

    it "correct fare by default" do
      expect(subject.fare).to eq 1
    end

    it "finish a journey" do
      expect(subject.finish).to eq @complete
    end
    
end