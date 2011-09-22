require 'spec/spec_helper'

#
# Tests for image model extensions
#
describe ShopDiscounts::Models::Purchaseable do

  dataset :shop_line_items, :shop_discounts

  before :each do
    ShopDiscountable.create(:discount => shop_discounts(:ten_percent), :discounted => shop_line_items(:one))
  end

  describe '#value' do
    it 'it should return the price of the items' do
      shop_line_items(:one).value.should === shop_line_items(:one).item.price
    end
  end

  describe '#per_item_discount' do
    it 'returns the discount in $ ($1.1)' do
      shop_line_items(:one).per_item_discount.should == 1.1
    end

    context 'when amount is specified in currency' do
      before do
        shop_discounts(:ten_percent).update_attributes!(:amount_type => 'currency')
      end

      it 'returns the discount in $ ($10)' do
        shop_line_items(:one).per_item_discount.should == 10
      end
    end
  end

  describe '#total_discount' do
    it 'returns the discount in $ ($1.1)' do
      shop_line_items(:one).total_discount.should == 1.1
    end

    context 'there are multiple items' do
      before do
        shop_line_items(:one).update_attributes!(:quantity => 3)
      end

      it 'returns the discount in $ ($3.3)' do
        shop_line_items(:one).total_discount.should == 3.3
      end
    end
  end

  describe '#discounted?' do
    subject { shop_line_items(:one).discounted? }

    it { should be_true }

    context 'discount is removed' do
      before do
        shop_line_items(:one).discounts.destroy_all
      end

      it { should be_false }
    end
  end

  describe '#price' do
    it 'should return the discounted price of the product' do
      shop_line_items(:one).price.should === shop_line_items(:one).discounted_price
    end
  end
end
