require 'spec/spec_helper'

describe Admin::Shop::Discounts::DiscountablesController do
  
  dataset :users, :shop_discountables
  
  before :each do
    login_as :admin
    @discountable = shop_discountables(:ten_percent_bread)
  end
  
  describe '#create' do
    before :each do
      @discounted = shop_products(:warm_bread)
    end
    context 'packing could not be created' do
      before :each do
        stub(ShopDiscountable).new { @discountable }
        mock(@discountable).save! { raise ActiveRecord::RecordNotSaved }
      end
      
      context 'js' do
        it 'should return error notice and failure status' do
          post :create, :discount_id => @discountable.discount.id, :discounted_id => @discounted.id, :discounted_type => @discounted.class.name, :format => 'js'
          
          response.body.should === 'Could not attach Discount.'
          response.should_not be_success
        end
      end
    end

    context 'packing successfully created' do
      context 'js' do
        it 'should render the collection partial and success status' do
          post :create, :discount_id => @discountable.discount.id, :discounted_id => @discounted.id, :discounted_type => @discounted.class.name, :format => 'js'

          response.should be_success
          assigns(:shop_discountable).is_a?(ShopDiscountable).should === true
          response.should render_template('admin/shop/discounts/edit/shared/_product')
        end
      end
    end
  end
  
  describe '#destroy' do    
    context 'discountable not destroyed' do
      before :each do
        stub(ShopDiscountable).find(@discountable.id.to_s) { @discountable }
        stub(@discountable).destroy { raise ActiveRecord::RecordNotFound }
      end
      
      context 'js' do
        it 'should render an error and failure status' do
          delete :destroy, :discount_id => @discountable.discount.id, :id => @discountable.id, :format => 'js'
          
          response.should_not be_success
          response.body.should === 'Could not remove Discount.'
        end
      end
    end
    
    context 'discountable successfully destroyed' do
      context 'js' do
        it 'should render success message and success status' do
          delete :destroy, :discount_id => @discountable.discount.id, :id => @discountable.id, :format => 'js'
          response.should be_success
          response.should render_template('admin/shop/discounts/edit/shared/_category')
        end
      end
    end
  end
  
end