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
      tag 'shop:discount:total_price_with_discount' do |tag|
        tag.locals.current_discount.total_products_price_with_discount
      end

      desc %{Outputs the name of the package}
      tag 'shop:discount:name' do |tag|
        tag.locals.current_discount.name
      end

      desc %{Outputs the total price of all products in the package without discount}
      tag 'shop:discount:total_price_without_discount' do |tag|
        tag.locals.current_discount.total_products_price_without_discount
      end

      desc %{Outputs the total price of all products in the package without discount}
      tag 'shop:discount:total_price_without_discount' do |tag|
        tag.locals.current_discount.total_products_price_without_discount
      end


      # TODO: Fix Below

      desc 'Expands the child tags for each product that makes part of the current discount'
      tag 'shop:discount:products:each' do |tag|
        tag.locals.current_discount.products.inject('') do |content, product|
          tag.locals.discounted_product = product
          content + tag.expand
        end
      end

      desc 'Prints the name of the product that is eligible for a discount'
      tag 'shop:discount:products:each:name' do |tag|
        tag.locals.discounted_product.name
      end

      desc 'Prints the description of the product that is eligible for a discount'
      tag 'shop:discount:products:each:description' do |tag|
        tag.locals.discounted_product.description
      end

    end
  end
end
