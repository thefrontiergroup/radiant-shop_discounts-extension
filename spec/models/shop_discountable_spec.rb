require 'spec/spec_helper'

describe ShopDiscountable do
  
  dataset :shop_discountables, :shop_line_items
  
  before(:each) do
    @discount  = shop_discounts(:ten_percent)
  end
  
  describe 'validations' do
    before :each do
      @discountable = shop_discountables(:ten_percent_bread)
    end
    
    context 'discount' do
      it 'should require' do
        @discountable.discount = nil
        @discountable.valid?.should === false
      end
    end
    
    context 'discounted' do
      it 'should require' do
        @discountable.discounted = nil
        @discountable.valid?.should === false
      end
      it 'should be unique to the class' do
        @other = ShopDiscountable.new(:discount => @discount, :discounted => @discountable.discounted)
        @other.valid?.should === false
        
        @other.discounted = shop_categories(:milk)
        @other.valid?.should === true
      end
    end
  end
  
  describe 'category and product hooks' do
    describe '#create' do
      before :each do
        @discount = shop_discounts(:one_percent)
        @category = shop_categories(:milk)
        
        discountable = @discount.discountables.create(:discounted => @category)      
      end
      it 'should assign the category to the discount' do
        @discount.categories.include?(@category).should be_true
      end
      it 'should assign the products to that category' do
        @discount.products.should_not be_empty
        @discount.products.should === @category.products
      end
    end
  
    describe '#destroy' do
      before :each do
        @discount = shop_discounts(:one_percent)
        @category = shop_categories(:milk)
        
        discountable = @discount.discountables.create(:discounted => @category)
        discountable.destroy
      end
      it 'should remove the category to the discount' do
        @discount.categories.include?(@category).should be_false
      end
      it 'should remove the products of that category' do
        @category.products.each do |p|
          @discount.products.include?(p).should be_false
        end
      end
    end
  end
  
  describe 'order and line_item hooks' do
    before :each do      
      @discount = shop_discounts(:one_percent)
      @order    = shop_orders(:several_items)
      @line_item_one = shop_orders(:several_items).line_items.first
      @line_item_two = shop_orders(:several_items).line_items.last
      
      # Creates a discount for the items product
      @discount.discountables.create(:discounted_id => @line_item_one.item.id, :discounted_type => @line_item_one.item.class.name)
    end
    describe '#create' do
      before :each do
        discountable = @discount.discountables.create(:discounted => @order)
      end
      it 'should assign the category to the discount' do
        @discount.orders.include?(@order).should be_true
      end
      it 'should assign only the items with discounted products to that category' do
        @discount.line_items.should_not be_empty
        @discount.line_items.include?(@line_item_one).should be_true
        @discount.line_items.include?(@line_item_two).should be_false
      end
    end
  
    describe '#destroy' do
      before :each do
        discountable = @discount.discountables.create(:discounted => @order)
        discountable.destroy
      end
      it 'should remove the category to the discount' do
        @discount.orders.include?(@order).should be_false
      end
      it 'should remove the products of that category' do
        @order.line_items.each do |p|
          @discount.line_items.include?(p).should be_false
        end
      end
    end
  end
  
end