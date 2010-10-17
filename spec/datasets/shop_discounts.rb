class ShopDiscountsDataset < Dataset::Base  
  
  uses :shop_categories, :shop_products
  
  def load
    create_record :shop_discounts, :ten_percent,
      :name        => 'ten percent',
      :code        => '10pcoff',
      :amount      => 10.00
      
    create_record :shop_discounts, :five_percent,
      :name        => 'five percent',
      :code        => '5pcoff',
      :amount      => 10.00
      
    create_record :shop_discounts, :one_percent,
      :name        => 'one percent',
      :code        => '1pcoff',
      :amount      => 1.00,
      :starts_at   => nil,
      :finishes_at => nil
    
    create_record :shop_discounts, :invalid,
      :name        => 'invalid',
      :code        => 'invalid',
      :amount      => 100,
      :starts_at   => Time.now - 5.days,
      :finishes_at => Time.now - 2.days
      
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