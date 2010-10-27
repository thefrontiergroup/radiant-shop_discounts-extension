require 'spec/spec_helper'

describe ShopProduct do
  dataset :shop_products, :shop_line_items, :shop_discountables

  
  describe 'relationships' do
    before :each do
      @product = shop_products(:crusty_bread)
    end
    
    it 'should have many discountables' do
      @product.discountables.is_a?(Array).should be_true
    end
      
    it 'should have many discounts' do
      @product.discounts.is_a?(Array).should be_true
    end
  end
  
  context 'discounts' do
    context 'after_create' do
      it 'should assign its categories discounts to itself' do
        @product = ShopProduct.new(
          :price => 11.11,
          :page_attributes => {
            :title => 'New Page With Discounts',
            :slug  => 'new_page_with_discounts',
            :parent_id => shop_categories(:bread).id
          } 
        )
        @product.discounts.empty?.should === true
        @product.save
      
        ShopProduct.find(@product).discounts.should === shop_categories(:bread).discounts
      end
    end
  end
  
end