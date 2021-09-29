require 'oystercard'

describe Oystercard do
  let(:card_limit) { Oystercard::CARD_LIMIT }
  let(:min_charge) { Oystercard::MIN_CHARGE }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { {entry: entry_station, exit: exit_station} }

  describe '#initialize' do
    
    it "gives a new oystercardwith a balance of 0" do
      expect(subject.balance).to eq 0
    end

    it 'gives a new oystercard which is not in use' do
      expect(subject.in_use).to eq false
    end
    
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
  
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end 
  
    it 'balance cannot exceed £90' do
      subject.top_up(card_limit)
      expect { subject.top_up(1) }.to raise_error "Cannot exceed limit of £#{card_limit}"
    end

  end

  # allow_any_instance_of(Oystercard).to receive (:deduct) do
  
  # describe "#deduct" do
  #   it { is_expected. to respond_to(:deduct).with(1).argument }
    
  #   it 'will deduct money from card' do
  #   subject.top_up(10)
  #   expect { subject.deduct 1 }.to change { subject.balance }.by -1
  #   end

  # end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe 'touching in and out' do
    before(:each) do
      subject.top_up(card_limit)
    end

    describe '#touch_in' do
      it { is_expected.to respond_to(:touch_in) }
      
      it 'causes card to be in use' do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it 'not work if balance below minimum amount' do
        subject.send(:deduct, card_limit)
        expect { subject.touch_in(entry_station) }.to raise_error "Not enough credit for journey"
      end
        
      it 'remembers the entry station' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end

    end

    describe '#touch_out' do
      it { is_expected.to respond_to(:touch_out) }

      it 'causes card to be not in use' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end

      it "charge is made" do
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by (-min_charge)
      end

      it "knows exit station" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end

    end

    it "store an empty list of journeys" do
      expect(subject.journeys).to eq []
    end

    it "stores a journey" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      subject.trip_history
      expect(subject.journeys).to include journey
    end

  end
    
end
