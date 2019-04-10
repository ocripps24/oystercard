require 'Oystercard'

describe Oystercard do

  let(:station) { double :station }

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
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end
    end

    context 'when touched out' do
      it "returns false" do
        subject.top_up(Oystercard::MIN_CHARGE)
        subject.touch_in(station)
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end

  describe '#touch_in' do
    context 'when balance is below minimum balance' do
      it "raises an error" do
        expect { subject.touch_in(station) }.to raise_error "Balance below minimum"
      end
    end

    context 'when balance is above minimum balance' do
      it 'records the station' do
        subject.top_up(Oystercard::MIN_CHARGE)
        expect(subject.touch_in(station)).to eq station
      end
    end
  end

  describe '#touch_out' do
    it 'deducts the journey cost from the balance' do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in(station)
      expect {subject.touch_out}.to change{subject.balance}.by -Oystercard::MIN_CHARGE
    end
  end

end
