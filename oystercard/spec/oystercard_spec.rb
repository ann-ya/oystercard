require 'oystercard'

describe Oystercard do
  let(:card_limit) { Oystercard::CARD_LIMIT }

  it "gives a new oystercardwith a balance" do
    expect(subject.balance).to eq 0
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

  describe "#deduct" do
    it { is_expected. to respond_to(:deduct).with(1).argument }
    
    it 'will deduct money from card' do
    subject.top_up(10)
    expect { subject.deduct 1 }.to change { subject.balance }.by -1
    end
  end

end