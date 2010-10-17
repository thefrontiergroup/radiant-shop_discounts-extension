require 'spec/spec_helper'

describe FormDiscount do
  
  dataset :shop_discounts, :pages, :forms
  
  before :each do
    mock_page_with_request_and_data
  end
    
  describe '#create' do
    before :each do
      login_as :customer
      @order = shop_orders(:several_items)
    end
    context 'add' do
      before :each do
        mock_valid_form_discount_request
      end
      context 'valid discount' do
        before :each do
          @discount = FormDiscount.new(@form, @page)
          @result = @discount.create
        end
        it 'should add the discount to the order' do
          shop_orders(:several_items).discounts.first(:conditions => { :code => '10pcoff' }).should_not be_nil
        end
        it 'should return true for result[:add]' do
          @result[:add].should be_true
        end
      end
      context 'invalid discount' do
        before :each do
          @data[:discount][:code] = 'invalid'
        end
        it 'should not add the discount to the order' do
          shop_orders(:several_items).discounts.first(:conditions => { :code => 'invalid' }).should be_nil
        end
      end
    end
    
    context 'remove' do
      before :each do
        discountable = shop_discounts(:ten_percent).discountables.create(:discounted_id => @order.id, :discounted_type => @order.class.name)
        
        mock_valid_form_discount_request
        @form[:extensions][:discount][:process] = 'remove'
        @data[:discountable] = { :id => discountable.id }
        
        @discount = FormDiscount.new(@form, @page)
        @result = @discount.create
      end
      it 'should remove the discount from the order' do
        shop_orders(:several_items).discounts.include?(shop_discounts(:ten_percent)).should be_false
      end  
      it 'should return true for result[:remove]' do
        @result[:remove].should be_true
      end
    end
    
  end
  
end