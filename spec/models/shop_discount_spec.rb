require 'spec/spec_helper'

describe ShopDiscount do
  
  dataset :shop_discounts, :shop_products, :shop_orders

  describe 'scope' do
    before :each do
      @valid   = ShopDiscount.all_including_invalid(:conditions => { :code => '10pcoff'}).first
      @invalid = ShopDiscount.all_including_invalid(:conditions => { :code => 'invalid'}).first
    end
    context 'all' do
      it 'should not return invalid by default' do
        ShopDiscount.all.include?(@valid).should   be_true
        ShopDiscount.all.include?(@invalid).should be_false
      end
    end
    context 'all_including_invalid' do
      it 'should return all including invalid' do
        ShopDiscount.all_including_invalid.include?(@valid).should   be_true
        ShopDiscount.all_including_invalid.include?(@invalid).should be_true
      end
    end
  end

  describe 'validations' do
    before :each do
      @discount = shop_discounts(:ten_percent)
    end
    
    context 'name' do
      it 'should require' do
        @discount.name = nil
        @discount.valid?.should === false
      end
      it 'should be unique' do
        @other = shop_discounts(:five_percent)
        @other.name = @discount.name
        @other.valid?.should === false
      end
    end
    
    context 'code' do
      it 'should require' do
        pending
        @discount.code = nil
        @discount.valid?.should === false
      end
      it 'should be unique' do
        @other = shop_discounts(:five_percent)
        @other.code = @discount.code
        @other.valid?.should === false
      end
    end
    
    context 'amount' do
      it 'should require' do
        @discount.amount = nil
        @discount.valid?.should === false
      end
      it 'should be numerical' do
        @discount.amount = 'failure'
        @discount.valid?.should === false
      end
    end
  end
  
  describe 'relationships' do
    before :each do
      @discount = shop_discounts(:five_percent)
    end
    context 'categories' do
      before :each do
        @bread = shop_categories(:bread)
      end
      it 'should have many' do
        @discount.discountables.create(:discounted => @bread)
        @discount.categories.include?(@bread).should === true
      end
      context '#for' do
        before :each do
          @discount.discountables.create(:discounted => shop_categories(:bread))
          @discount.discountables.create(:discounted => shop_categories(:milk))
          @discount.discountables.create(:discounted => shop_products(:crusty_bread))
          @discount.discountables.create(:discounted => shop_products(:full_milk))
        end
        it 'should return result of only that type' do
          discountables = @discount.discountables.for('ShopCategory')
          discountables.each do |d|
            d.discounted.is_a?(ShopCategory).should === true
          end
        end
        it 'should return result of only that type regardless of string format' do
          discountables = @discount.discountables.for('Shop_category')
          discountables.each do |d|
            d.discounted.is_a?(ShopCategory).should === true
          end
          
          discountables = @discount.discountables.for('shop_category')
          discountables.each do |d|
            d.discounted.is_a?(ShopCategory).should === true
          end
          
          discountables = @discount.discountables.for('ShopProduct')
          discountables.each do |d|
            d.discounted.is_a?(ShopProduct).should === true
          end
        end
      end
    end
  end
  
  describe '#available_categories' do
    before :each do
      @discount = shop_discounts(:ten_percent)
    end
    it 'should return all categories minus its own' do
      @discount.available_categories.should === ShopCategory.all - @discount.categories
    end
  end
  
  describe '#available_products' do
    before :each do
      @discount = shop_discounts(:ten_percent)
    end
    it 'should return all products minus its own' do
      @discount.available_products.should === ShopProduct.all - @discount.products
    end
  end

  describe '#total_products_price' do

    let(:discount) { shop_discounts(:ten_percent) }

    before :each do
      discount.discountables.create(:discounted => shop_products(:full_milk))
      discount.discountables.create(:discounted => shop_products(:hilo_milk))
    end

    it 'should return the total price of all products minus the discount' do
      # First product is $10 and second is $11 so total is ($21 - 10% discount) == $18.90
      discount.total_products_price.should == 18.90
    end

  end

end
