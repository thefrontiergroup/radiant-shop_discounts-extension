class CategoryShopDiscountable < ShopDiscount
  
  before_validation       :create_shop_products
  before_destroy          :destroy_shop_products
  
  # Adds discount to a category's products
  def create_shop_products
    discounted.products.each do |product|
      # Attach discount to the child product
      ShopDiscountable.create(:discount => discount, :discounted => product)
    end
  end
  
  # Removes discount from a category's products
  def destroy_shop_products
    discounted.discountables.for('ShopProduct').each do |discountable|
      discountable.destroy
    end
  end
  
end