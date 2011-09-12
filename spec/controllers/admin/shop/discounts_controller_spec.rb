require File.dirname(__FILE__) + "/../../../spec_helper"

describe Admin::Shop::DiscountsController do
  
  dataset :users, :shop_discounts
  
  before(:each) do
    login_as  :admin
  end
  
  describe 'index' do
    context 'instance variables' do
      it 'should be assigned' do
        get :index
        
        assigns(:inputs).should   include()
        assigns(:meta).should     include()
        assigns(:buttons).should  include('new_discount')
        assigns(:parts).should    include()
        assigns(:popups).should   include()
      end
    end
  end
  
  describe '#new' do
    context 'instance variables' do
      it 'should be assigned' do
        get :new
        
        #assigns(:inputs).should   include('name','amount','code')
        assigns(:inputs).should   include('name','amount')
        #assigns(:meta).should     include('start','finish')
        assigns(:buttons).should  include()
        assigns(:parts).should    include()
        assigns(:popups).should   include()
      end
    end
  end
  
  describe '#edit' do
    context 'instance variables' do
      it 'should be assigned' do
        get :edit, :id => shop_discounts(:ten_percent).id
        
        #assigns(:inputs).should   include('name','amount','code')
        assigns(:inputs).should   include('name','amount')
        #assigns(:meta).should     include('start','finish')
        assigns(:buttons).should  include('browse_categories', 'browse_products','browse_users')
        assigns(:parts).should    include('categories', 'products','users')
        assigns(:popups).should   include('browse_categories', 'browse_products','browse_users')
      end
    end
  end
  
  describe '#create' do
    context 'instance variables' do
      it 'should be assigned' do
        post :create, :shop_variant => {}
        
        #assigns(:inputs).should   include('name','amount','code')
        assigns(:inputs).should   include('name','amount')
        #assigns(:meta).should     include('start','finish')
        assigns(:buttons).should  include()
        assigns(:parts).should    include()
        assigns(:popups).should   include()
      end
    end
  end
  
  describe '#update' do
    context 'instance variables' do
      it 'should be assigned' do
        put :update, :id => shop_discounts(:ten_percent).id, :shop_variant => {}
        
        #assigns(:inputs).should   include('name','amount','code')
        assigns(:inputs).should   include('name','amount')
        #assigns(:meta).should     include('start','finish')
        assigns(:buttons).should  include('browse_categories', 'browse_products','browse_users')
        assigns(:parts).should    include('categories', 'products','users')
        assigns(:popups).should   include('browse_categories', 'browse_products','browse_users')
      end
    end
  end
  
end
