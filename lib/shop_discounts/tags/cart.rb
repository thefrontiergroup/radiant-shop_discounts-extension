module ShopDiscounts
  module Tags
    module Cart
      include Radiant::Taggable
      
      [:value, :markdown].each do |symbol|
        desc %{ outputs the #{symbol} of the current cart item }
        tag "shop:cart:#{symbol}" do |tag|
          attr = tag.attr.symbolize_keys
          order = tag.locals.shop_order
          
          Shop::Tags::Helpers.currency(order.send(symbol),attr)
        end
      end
      
    end
  end
end