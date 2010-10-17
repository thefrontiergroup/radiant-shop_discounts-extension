class SetupShopDiscounts < ActiveRecord::Migration
  def self.up
    create_table "shop_discountables", :force => true do |t|
      t.integer  "discount_id"
      t.integer  "discounted_id"
      t.string   "discounted_type"
      t.integer  "created_by"
      t.datetime "created_at"
      t.integer  "updated_by"
      t.datetime "updated_at"
    end

    create_table "shop_discounts", :force => true do |t|
      t.string   "name"
      t.string   "code"
      t.decimal  "amount"
      t.datetime "starts_at"
      t.datetime "finishes_at"
      t.integer  "created_by"
      t.integer  "updated_by"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    remove_table "shop_discountables"
    remove_table "shop_discounts"
  end
end
