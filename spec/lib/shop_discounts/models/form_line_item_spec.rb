require File.dirname(__FILE__) + "/../../../spec_helper"

describe ShopDiscounts::Models::FormLineItem do
  
  dataset :forms_discount, :shop_discountables, :shop_orders, :shop_line_items
  
  before :each do
    mock_page_with_request_and_data
    @order = shop_orders(:several_items)
    mock_valid_form_line_item_request
    
    @form_line_item = FormLineItem.new(@form, @page, @form[:extensions][:add_line_item])
  end
  
  it 'should define #create_with_discounts' do
    @form_line_item.respond_to?('create_with_discounts').should be_true
  end
  
  it 'should call #create_shop_line_items_if_shop_order on the order' do
    discountable = Object.new
    mock(discountable).create_shop_line_items
    mock(@order).discountables.returns [discountable]
    mock(ShopOrder).find_by_session(anything).returns @order
    
    @form_line_item.create
  end
  
end
