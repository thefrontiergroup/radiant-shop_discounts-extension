require 'spec/spec_helper'

#
# Test for ShopDiscounts Item Tag Extensions
#
describe ShopDiscounts::Tags::Item do
  
  dataset :pages, :shop_orders, :shop_line_items
  
  it 'should describe these tags' do
    ShopDiscount::Tags::Item.tags.sort.should == [
      'shop:cart:item:value',
      'shop:cart:item:discount',
      'shop:cart:item:if_discounted',
      'shop:cart:item:unless_discounted'].sort
  end
  
  context 'page tags' do
    
    before :all do
      @page = pages(:home)
    end
    
    before :each do
      @cart = shop_orders(:several_items)
      @line_item = @cart.line_items.first
      mock(Shop::Tags::Helpers).current_line_item(anything) { @line_item }
    end
  
    describe '<r:shop:cart:item:value />' do
      it 'should return the value of the item' do
        tag = %{<r:shop:cart:item:value />}
        exp = Shop::Tags::Helpers.currency(@line_item.value)
        
        @page.should render(tag).as(exp)
      end
    end
  
    describe '<r:shop:cart:item:discount />' do
      it 'should return the markdown of the item' do
        tag = %{<r:shop:cart:item:discount />}
        exp = Shop::Tags::Helpers.currency(@line_item.discount)
        
        @page.should render(tag).as(exp)
      end
    end
  
    describe '<r:shop:cart:item:if_discounted />' do
      it 'should be written'
    end
  
    describe '<r:shop:cart:item:unless_discounted />' do
      it 'should be written'
    end
    
  end
  
end