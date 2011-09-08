class AddDiscountcodeToShopLineItems < ActiveRecord::Migration
  def self.up
    add_column :shop_line_items, :discount_code, :string
  end

  def self.down
    remove_column :shop_line_items, :discount_code
  end
end
