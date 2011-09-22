class AddAmountTypeToDiscounts < ActiveRecord::Migration
  def self.up
    change_table "shop_discounts" do |t|
      t.string "amount_type", :default => "percentage", :null => false
    end
  end

  def self.down
    change_table "shop_discounts" do |t|
      t.remove "amount_type"
    end
  end
end

