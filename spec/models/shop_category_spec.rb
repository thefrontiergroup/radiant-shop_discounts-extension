require 'spec/spec_helper'

describe ShopCategory do
  
  dataset :shop_categories
  
  before :each do
    @category = shop_categories(:bread)
  end
  
  it 'should have many discountables' do
    @category.discountables.is_a?(Array).should be_true
  end
  
  it 'should have many discounts' do
    @category.discounts.is_a?(Array).should be_true
  end
  
end