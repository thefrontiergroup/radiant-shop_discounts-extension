module ShopDiscounts
  module Tags
    module Item
      include Radiant::Taggable
      [:value, :discount, :discounted, :rrp].each do |symbol|
        desc %{ outputs the #{symbol} of the current cart item }
        tag "shop:cart:item:#{symbol}" do |tag|
          attr = tag.attr.symbolize_keys
          item = tag.locals.shop_line_item

          Shop::Tags::Helpers.currency(item.send(symbol),attr)
        end
      end

      desc %{ outputs the discount code of the current cart item }
      tag 'shop:cart:item:discount_code' do |tag|
        tag.locals.shop_line_item.discount_code
      end

      desc %{ expands if the item has a discount applied with a discount code }
      tag 'shop:cart:item:if_discounted_with_code' do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.discounts.any? { |discount| discount.code == item.discount_code }
      end

      desc %{ expands if the item does not have a discount applied with a discount code }
      tag 'shop:cart:item:unless_discounted_with_code' do |tag|
        item = tag.locals.shop_line_item

        tag.expand unless item.discounts.any? { |discount| discount.code == item.discount_code }
      end

      desc %{ expands if the item has a discount}
      tag "shop:cart:item:if_discounted" do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.price != item.value
      end

      desc %{ expands if the item has a discount}
      tag "shop:cart:item:unless_discounted" do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.price == item.value
      end
    end
  end
end
