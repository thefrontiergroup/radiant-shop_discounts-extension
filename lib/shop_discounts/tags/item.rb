module ShopDiscounts
  module Tags
    module Item
      include Radiant::Taggable
      [:value, :markdown].each do |symbol|
        desc %{ outputs the #{symbol} of the current cart item }
        tag "shop:cart:item:#{symbol}" do |tag|
          attr = tag.attr.symbolize_keys
          item = tag.locals.shop_line_item

          Helpers.currency(item.send(symbol),attr)
        end
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