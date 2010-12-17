class ShopDiscountablesDataset < Dataset::Base  
  
  uses :shop_discounts, :shop_products, :shop_categories, :shop_orders
  
  def load
    create_record :shop_discountables, :ten_percent_bread,
      :discount_id     => shop_discounts(:ten_percent).id,
      :discounted_id   => shop_categories(:bread).id,
      :discounted_type => shop_categories(:bread).class.name

    create_record :shop_discountables, :five_percent_bread,
      :discount_id     => shop_discounts(:five_percent).id,
      :discounted_id   => shop_categories(:bread).id,
      :discounted_type => shop_categories(:bread).class.name

    create_record :shop_discountables, :five_percent_crusty_bread,
      :discount_id     => shop_discounts(:five_percent).id,
      :discounted_id   => shop_products(:crusty_bread).id,
      :discounted_type => shop_products(:crusty_bread).class.name
      
    create_record :shop_discountables, :several_items_five_percent,
      :discount_id     => shop_discounts(:five_percent).id,
      :discounted_id   => shop_orders(:several_items).id,
      :discounted_type => shop_orders(:several_items).class.name
      
    create_record :shop_discountables, :admin_ten_percent,
      :discount_id     => shop_discounts(:ten_percent).id,
      :discounted_id   => users(:admin).id,
      :discounted_type => users(:admin).class.name
      
  end
    
end