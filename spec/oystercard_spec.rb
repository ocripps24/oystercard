require 'Oystercard'

describe Oystercard do
  describe '#balance' do
    it 'returns a balance' do
      expect(subject.balance).to eq 0
    end
  end
end
