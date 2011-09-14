module ShopDiscounts
  module Tags
    module Discount
      include Radiant::Taggable

      desc %{Expand the tag if a matching discount is found with the passed in name}
      tag 'shop:discount' do |tag|
        discount_name = tag.attributes['name']
        discount      = ShopDiscount.find(:first, :conditions => { :name => discount_name })
        tag.locals.current_discount = discount
        tag.expand if discount.present?
      end

      desc %{Outputs the total price of all products in the package with discount included}
      tag 'shop:discount:total_price' do |tag|
        debugger
        true
      end

    end
  end
end
