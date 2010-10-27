ActionController::Routing::Routes.draw do |map|

  
  map.namespace :admin do |admin|
    admin.namespace :shop, :member => { :remove => :get } do |shop|  
      shop.resources :products, :except => :new, :collection => { :sort => :put } do |product|
        product.resources :discounts,         :controller => 'products/discounts',          :only => [ :create, :destroy]
        product.resources :discount_templates,:controller => 'products/discount_templates', :only => [ :update ]
      end
      
      shop.resources :discounts, :member => { :remove => :get } do |discounts|
        discounts.resources :discountables,   :controller => 'discounts/discountables',     :only => [:create,:destroy]
      end
    end
  end

end