require 'Oystercard'

describe Oystercard do

  let(:in_station)    { double :in_station }
  let(:out_station)   { double :out_station }
  let(:entry_station) { double :entry_station }
  let(:exit_station)  { double :exit_station }
  let(:journey)       { { entrance: entry_station, exit: exit_station } }

  context 'when initialized' do
    it "checks journey log is empty" do
      expect(subject.journies).to be_empty
    end
  end

  it "stores a journey" do
    subject.top_up(Oystercard::MIN_CHARGE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journies).to include journey
  end

  describe '#balance' do
    it 'returns a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "tops up the balance" do
      expect { subject.top_up(10) }.to change{ subject.balance }.by 10
    end

    context 'if balance exceeds £90' do
      it 'raises an error' do
        maximum_balance = Oystercard::MAX_BALANCE
        subject.top_up(maximum_balance)
        expect { subject.top_up(1) }.to raise_error "Max balance #{maximum_balance} reached"
      end
    end
  end

  # describe '#deduct' do
  #   it "subtracts the journey amount from the balance" do
  #     subject.top_up(50)
  #     expect { subject.deduct(10) }.to change{ subject.balance }.by -10
  #   end
  # end

  describe '#in_journey?' do
    it "at card creation should return false" do
      expect(subject).not_to be_in_journey
    end

    context 'when touched in' do
      it "returns true" do
        subject.top_up(Oystercard::MIN_CHARGE)
        subject.touch_in(in_station)
        expect(subject).to be_in_journey
      end
    end

    context 'when touched out' do
      it "returns false" do
        subject.top_up(Oystercard::MIN_CHARGE)
        subject.touch_in(in_station)
        subject.touch_out(out_station)
        expect(subject).not_to be_in_journey
      end
    end
  end

  describe '#touch_in' do
    context 'when balance is below minimum balance' do
      it "raises an error" do
        expect { subject.touch_in(in_station) }.to raise_error "Balance below minimum"
      end
    end

    context 'when balance is above minimum balance' do
      it 'records the entrance station' do
        subject.top_up(Oystercard::MIN_CHARGE)
        subject.touch_in(in_station)
        expect(subject.entry_station).to eq in_station
      end

      it "resets the exit station to nil " do
        subject.top_up(Oystercard::MIN_CHARGE)
        subject.touch_in(in_station)
        expect(subject.exit_station).to eq nil
      end
    end
  end

  describe '#touch_out' do
    it 'deducts the journey cost from the balance' do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in(in_station)
      expect {subject.touch_out(out_station)}.to change{subject.balance}.by -Oystercard::MIN_CHARGE
    end

    it "resets the entry station to nil " do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in(in_station)
      subject.touch_out(out_station)
      expect(subject.entry_station).to eq nil
    end

    it 'records the exit station' do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in(in_station)
      subject.touch_out(out_station)
      expect(subject.exit_station).to eq out_station
    end
  end

end
