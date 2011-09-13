module ShopDiscounts
  module Tags
    module PossibleDiscounts
      include Radiant::Taggable

      desc "Expands the tag if the shopping cart contains items that are part of a package discount"
      tag "shop:cart:if_possible_discount" do |tag|
        order = tag.locals.shop_order
        tag.expand if order.possible_discounts?
      end

      desc "Expands the tag if the shopping cart does not contain items that are part of a package discount"
      tag "shop:cart:unless_possible_discount" do |tag|
        order = tag.locals.shop_order
        tag.expand unless order.possible_discounts?
      end

      desc "shop:cart:possible_discounts"
      tag "shop:cart:possible_discounts" do |tag|
        order = tag.locals.shop_order
        tag.locals.possible_discounts = order.possible_discounts
        tag.expand if tag.locals.possible_discounts.any?
      end

      desc "shop:cart:possible_discounts:each"
      tag "shop:cart:possible_discounts:each" do |tag|
        tag.locals.possible_discounts.inject('') do |content, discount|
          tag.locals.possible_discount = discount
          content + tag.expand
        end
      end

      desc "shop:cart:possible_discounts:each:name"
      tag "shop:cart:possible_discounts:each:name" do |tag|
        tag.locals.possible_discount.name
      end

      desc "shop:cart:possible_discounts:each:amount"
      tag "shop:cart:possible_discounts:each:amount" do |tag|
        "#{tag.locals.possible_discount.amount}%"
      end

      desc "shop:cart:possible_discounts:each:products"
      tag "shop:cart:possible_discounts:each:products" do |tag|
        tag.locals.discounted_products = tag.locals.possible_discount.products
        tag.expand if tag.locals.discounted_products
      end

      desc "shop:cart:possible_discounts:each:products:each"
      tag "shop:cart:possible_discounts:each:products:each" do |tag|
        tag.locals.discounted_products.inject('') do |content, product|
          tag.locals.discounted_product = product
          content + tag.expand
        end
      end

    end
  end
end
