module ShopDiscounts
  module Tags
    module Item
      include Radiant::Taggable

      desc %{ outputs the value of the current cart item }
      tag "shop:cart:item:value" do |tag|
        attr = tag.attr.symbolize_keys
        item = tag.locals.shop_line_item

        Shop::Tags::Helpers.currency(item.value, attr)
      end

      desc %{ outputs the discount of the current cart item }
      tag "shop:cart:item:discount" do |tag|
        attr = tag.attr.symbolize_keys
        item = tag.locals.shop_line_item

        Shop::Tags::Helpers.currency(item.per_item_discount, attr) if item.purchaseable?
      end

      desc %{ outputs the discounted of the current cart item }
      tag "shop:cart:item:discounted" do |tag|
        attr = tag.attr.symbolize_keys
        item = tag.locals.shop_line_item

        amount = if item.purchaseable?
                   item.total_discount
                 else
                   item.item.discount_amount
                 end
        Shop::Tags::Helpers.currency(amount, attr)
      end

      desc %{ outputs the rrp of the current cart item }
      tag "shop:cart:item:rrp" do |tag|
        attr = tag.attr.symbolize_keys
        item = tag.locals.shop_line_item

        if item.purchaseable?
          Shop::Tags::Helpers.currency(item.rrp, attr)
        else
          '0'
        end
      end

      desc %{ outputs the discount code of the current cart item }
      tag 'shop:cart:item:discount_code' do |tag|
        tag.locals.shop_line_item.discount_code
      end

      desc %{ expands if the item has a discount applied with a discount code }
      tag 'shop:cart:item:if_discounted_with_code' do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.discount_code.present? && item.discounts.any? { |discount| discount.code == item.discount_code }
      end

      desc %{ expands if the item does not have a discount applied with a discount code }
      tag 'shop:cart:item:unless_discounted_with_code' do |tag|
        item = tag.locals.shop_line_item

        tag.expand unless item.discount_code.present? && item.discounts.any? { |discount| discount.code == item.discount_code }
      end

      desc %{ expands if the item has a discount}
      tag "shop:cart:item:if_discounted" do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.discounted?
      end

      desc %{ expands if the item has a discount}
      tag "shop:cart:item:unless_discounted" do |tag|
        item = tag.locals.shop_line_item

        tag.expand unless item.discounted?
      end

      desc %{ expands if the item refers to a product}
      tag "shop:cart:item:if_product" do |tag|
        item = tag.locals.shop_line_item

        tag.expand if item.purchaseable?
      end

      desc %{ expands unless the item refers to a product}
      tag "shop:cart:item:unless_product" do |tag|
        item = tag.locals.shop_line_item

        tag.expand unless item.purchaseable?
      end
    end
  end
end
