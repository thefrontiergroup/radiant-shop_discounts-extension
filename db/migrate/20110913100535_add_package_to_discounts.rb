class AddPackageToDiscounts < ActiveRecord::Migration
  def self.up
    change_table "shop_discounts" do |t|
      t.boolean "package", :default => false, :null => false
    end
  end

  def self.down
    change_table "shop_discounts" do |t|
      t.remove "package"
    end
  end
end
