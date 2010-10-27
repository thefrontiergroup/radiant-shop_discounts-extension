class ShopDiscountsDataset < Dataset::Base  
  
  def load
    create_record :shop_discounts, :ten_percent,
      :name        => 'ten percent',
      :code        => '10pcoff',
      :amount      => 10.00
      
    create_record :shop_discounts, :five_percent,
      :name        => 'five percent',
      :code        => '5pcoff',
      :amount      => 5.00
      
    create_record :shop_discounts, :one_percent,
      :name        => 'one percent',
      :code        => '1pcoff',
      :amount      => 1.00,
      :starts_at   => nil,
      :finishes_at => nil

    create_record :shop_discounts, :hundred_percent,
      :name        => 'hundred',
      :code        => 'hundred',
      :amount      => 100
        
    create_record :shop_discounts, :invalid,
      :name        => 'invalid',
      :code        => 'invalid',
      :amount      => 100,
      :starts_at   => Time.now - 5.days,
      :finishes_at => Time.now - 2.days
  end
  
end