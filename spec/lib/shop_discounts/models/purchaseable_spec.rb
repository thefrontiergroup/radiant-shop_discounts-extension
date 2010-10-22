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
  
  describe '#discount' do
    context 'single discount' do
      it 'should return the value of that discount as a percentage' do
        shop_line_items(:one).discount.should === (shop_discounts(:ten_percent).amount * 0.01)
      end
    end
    context 'multiple discounts' do
      before :each do
        ShopDiscountable.create(:discount => shop_discounts(:five_percent), :discounted => shop_line_items(:one))      
      end
      it 'should attach all discounts to the item' do
        shop_line_items(:one).discount.should == 0.15
      end
    end
    context 'too many discounts' do
      before :each do
        ShopDiscountable.create(:discount => shop_discounts(:hundred_percent), :discounted => shop_line_items(:one))      
      end
      it 'should return a capped discount amount' do
        shop_line_items(:one).discount.should == 1
      end
    end
  end

  describe '#discounted' do
    it 'should return how much has been taken off the product' do
      shop_line_items(:one).discounted.should === (shop_line_items(:one).item.price * 0.1)
    end
  end
  
  describe '#price' do
    it 'should return the discounted price of the product' do
      shop_line_items(:one).price.should === (shop_line_items(:one).value - shop_line_items(:one).discounted)
    end
  end  
end