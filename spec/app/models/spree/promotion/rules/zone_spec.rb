require 'spec_helper'

describe Spree::Promotion::Rules::Zone do
  let(:order) do
    double('Spree::Order',
      ship_address: ship_address
    )
  end

  it 'is a PromotionRule' do
    expect(subject).to be_a(Spree::PromotionRule)
  end

  describe 'eligibility' do
    context 'no shipping address' do
      let(:ship_address) { nil }

      it 'is not eligible if no shipping address' do
        
        expect(subject.eligible? order).to be_false
      end 
    end

    context 'shipping address in zone' do
      let(:ship_address) {
        double('Spree::Address')
      }

      let(:zones) {
        zone = Spree::Zone.new
        zone.stub(:include?).and_return(true)
        [zone]
      }

      before do
        subject.zones = zones
      end

      it 'is eligible' do
        expect(subject.eligible? order).to be_true
      end
    end

    context 'shipping address out of zone' do
      let(:ship_address) {
        double('Spree::Address')
      }

      let(:zones) {
        zone = Spree::Zone.new
        zone.stub(:include?).and_return(false)
        [zone]
      }

      before do
        subject.zones = zones
      end

      it 'is not eligible' do
        expect(subject.eligible? order).to be_false
      end
    end
  end
end