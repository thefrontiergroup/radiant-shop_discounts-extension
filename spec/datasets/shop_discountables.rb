class ShopDiscountablesDataset < Dataset::Base  
  
  uses :shop_discounts, :shop_products, :shop_categories
  
  def load
    create_record :shop_discountables, :ten_percent_bread,
      :discount_id    => shop_discounts(:ten_percent).id,
      :discounted_id  => shop_categories(:bread).id,
      :discounted_type => 'ShopCategory'

    create_record :shop_discountables, :five_percent_bread,
      :discount_id    => shop_discounts(:five_percent).id,
      :discounted_id  => shop_categories(:bread).id,
      :discounted_type => 'ShopCategory'

    create_record :shop_discountables, :five_percent_crusty_bread,
      :discount_id    => shop_discounts(:five_percent).id,
      :discounted_id  => shop_products(:crusty_bread).id,
      :discounted_type => 'ShopProduct'      
  end
    
end