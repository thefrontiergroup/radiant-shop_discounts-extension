require 'spec/spec_helper'

describe ShopOrder do
  dataset :shop_orders, :shop_line_items, :shop_discountables, :shop_customers
  
  context '#apply_customer_discounts' do
    
    it ' should assign the orders customer' do
      shop_orders(:several_items).discountables.should have(1).discountables
      shop_orders(:several_items).apply_customer_discounts
      shop_orders(:several_items).discountables.should have(2).discountables
    end
    
  end
  
  context '.find_by_session' do
    
    it 'should now call #apply_customer_discounts on the returned object' do
      @order = shop_orders(:several_items)
      mock(@order).apply_customer_discounts { true }
      mock(ShopOrder).find(@order.id) { @order }
      
      ShopOrder.find_by_session(@order.id)
    end
    
    it 'should return ActiveRecord::RecordNotFound if the order does not exist' do
      expect{ ShopOrder.find_by_session(1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
  end
  
end
