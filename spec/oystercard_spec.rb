require 'Oystercard'

describe Oystercard do
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

  describe '#deduct' do
    it "subtracts the journey amount from the balance" do
      subject.top_up(50)
      expect { subject.deduct(10) }.to change{ subject.balance }.by -10
    end
  end
end
