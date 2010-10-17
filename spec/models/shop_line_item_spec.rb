require 'spec/spec_helper'

describe ShopLineItem do
  
  dataset :shop_line_items, :shop_products, :shop_discountables
  
  context 'line item with a discount' do
    it 'should calculate a reduced price' do
      price = shop_line_items(:one).price
      ShopDiscountable.create(:discount => shop_discounts(:ten_percent), :discounted => shop_line_items(:one))
      shop_line_items(:one).price.should === (price-price*0.1)
    end
  end
  
end