module ShopDiscounts
  module Tags
    module PossibleDiscounts
      include Radiant::Taggable

      desc 'Expands the tag if the shopping cart contains items that are part of a package discount'
      tag 'shop:cart:if_possible_discount' do |tag|
        order = tag.locals.shop_order
        tag.expand if order.possible_discounts?
      end

      desc 'Expands the tag if the shopping cart does not contain items that are part of a package discount'
      tag 'shop:cart:unless_possible_discount' do |tag|
        order = tag.locals.shop_order
        tag.expand unless order.possible_discounts?
      end

      tag 'shop:cart:possible_discounts' do |tag|
        order = tag.locals.shop_order
        tag.locals.possible_discounts = order.possible_discounts
        tag.expand if tag.locals.possible_discounts.any?
      end

      desc 'Expands the child tags for each possible discount the current shopping cart may be eligible for if matching products are added'
      tag 'shop:cart:possible_discounts:each' do |tag|
        tag.locals.possible_discounts.inject('') do |content, discount|
          tag.locals.possible_discount = discount
          content + tag.expand
        end
      end

      tag 'shop:cart:possible_discounts:each:eligible_products' do |tag|
        order = tag.locals.shop_order
        tag.locals.products_in_discount = order.products_in_discount(tag.locals.possible_discount)
        tag.expand if tag.locals.products_in_discount.any?
      end

      desc 'A human readable list of the products in the cart eligible for the current possible discount e.g: Soap, Towels and Butter'
      tag 'shop:cart:possible_discounts:each:eligible_products:description' do |tag|
        tag.locals.products_in_discount.map(&:name).to_sentence
      end

      desc 'Expand the tag if there are multiple eligible products in the cart'
      tag 'shop:cart:possible_discounts:each:eligible_products:if_multiple' do |tag|
        tag.expand if tag.locals.products_in_discount.size > 1
      end

      desc 'Expand the tag if there are multiple eligible products in the cart'
      tag 'shop:cart:possible_discounts:each:eligible_products:unless_multiple' do |tag|
        tag.expand unless tag.locals.products_in_discount.size > 1
      end

      desc 'The name of the possible discount'
      tag 'shop:cart:possible_discounts:each:name' do |tag|
        tag.locals.possible_discount.name
      end

      desc 'The amount of the possible discount as a percentage'
      tag 'shop:cart:possible_discounts:each:rate' do |tag|
        "#{tag.locals.possible_discount.amount}%"
      end

      desc 'The amount of the possible discount in dollars'
      tag 'shop:cart:possible_discounts:each:amount' do |tag|
        Shop::Tags::Helpers.currency(tag.locals.possible_discount.discount_amount)
      end

      tag 'shop:cart:possible_discounts:each:products' do |tag|
        order = tag.locals.shop_order
        tag.locals.discounted_products = order.missing_products_for_discount(tag.locals.possible_discount)
        tag.expand if tag.locals.discounted_products
      end

      desc 'Expands the child tags for each product that makes part of the current possible discount'
      tag 'shop:cart:possible_discounts:each:products:each' do |tag|
        tag.locals.discounted_products.inject('') do |content, product|
          tag.locals.discounted_product = product
          content + tag.expand
        end
      end

      desc 'Prints the name of the product that is eligible for a discount if added to the current shopping cart'
      tag 'shop:cart:possible_discounts:each:products:each:name' do |tag|
        tag.locals.discounted_product.name
      end

      desc 'Prints the price of the product that is eligible for a discount if added to the current shopping cart'
      tag 'shop:cart:possible_discounts:each:products:each:price' do |tag|
        Shop::Tags::Helpers.currency(tag.locals.discounted_product.price)
      end

    end
  end
end
