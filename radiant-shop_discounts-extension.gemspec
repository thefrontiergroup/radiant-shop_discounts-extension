# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-shop_discounts-extension}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dirk Kelly"]
  s.date = %q{2011-01-11}
  s.description = %q{RadiantShop: Apply discounts to Products and Categories and have them accessed through codes}
  s.email = %q{dk@dirkkelly.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".DS_Store",
    "README",
    "Rakefile",
    "VERSION",
    "app/controllers/admin/shop/discounts/discountables_controller.rb",
    "app/controllers/admin/shop/discounts_controller.rb",
    "app/models/form_discount.rb",
    "app/models/shop_discount.rb",
    "app/models/shop_discountable.rb",
    "app/views/admin/shop/discounts/edit.html.haml",
    "app/views/admin/shop/discounts/edit/_foot.html.haml",
    "app/views/admin/shop/discounts/edit/_form.html.haml",
    "app/views/admin/shop/discounts/edit/_head.html.haml",
    "app/views/admin/shop/discounts/edit/_inputs.html.haml",
    "app/views/admin/shop/discounts/edit/_meta.html.haml",
    "app/views/admin/shop/discounts/edit/_parts.html.haml",
    "app/views/admin/shop/discounts/edit/_popups.html.haml",
    "app/views/admin/shop/discounts/edit/buttons/_browse_categories.html.haml",
    "app/views/admin/shop/discounts/edit/buttons/_browse_products.html.haml",
    "app/views/admin/shop/discounts/edit/buttons/_browse_users.html.haml",
    "app/views/admin/shop/discounts/edit/inputs/_amount.html.haml",
    "app/views/admin/shop/discounts/edit/inputs/_code.html.haml",
    "app/views/admin/shop/discounts/edit/inputs/_name.html.haml",
    "app/views/admin/shop/discounts/edit/meta/_finish.html.haml",
    "app/views/admin/shop/discounts/edit/meta/_start.html.haml",
    "app/views/admin/shop/discounts/edit/parts/_categories.html.haml",
    "app/views/admin/shop/discounts/edit/parts/_products.html.haml",
    "app/views/admin/shop/discounts/edit/parts/_users.html.haml",
    "app/views/admin/shop/discounts/edit/popups/_browse_categories.html.haml",
    "app/views/admin/shop/discounts/edit/popups/_browse_products.html.haml",
    "app/views/admin/shop/discounts/edit/popups/_browse_users.html.haml",
    "app/views/admin/shop/discounts/edit/shared/_category.html.haml",
    "app/views/admin/shop/discounts/edit/shared/_product.html.haml",
    "app/views/admin/shop/discounts/edit/shared/_user.html.haml",
    "app/views/admin/shop/discounts/index.html.haml",
    "app/views/admin/shop/discounts/index/_discount.html.haml",
    "app/views/admin/shop/discounts/index/_foot.html.haml",
    "app/views/admin/shop/discounts/index/_head.html.haml",
    "app/views/admin/shop/discounts/index/buttons/_new_discount.html.haml",
    "app/views/admin/shop/discounts/new.html.haml",
    "app/views/admin/shop/discounts/remove.html.haml",
    "config/locales/en.yml",
    "config/routes.rb",
    "cucumber.yml",
    "db/migrate/20101015162137_setup_shop_discounts.rb",
    "features/support/env.rb",
    "features/support/paths.rb",
    "lib/radiant-shop_discounts-extension.rb",
    "lib/shop_discounts/models/discountable.rb",
    "lib/shop_discounts/models/form_line_item.rb",
    "lib/shop_discounts/models/purchaseable.rb",
    "lib/shop_discounts/models/shop_order.rb",
    "lib/shop_discounts/models/shop_product.rb",
    "lib/shop_discounts/tags/cart.rb",
    "lib/shop_discounts/tags/item.rb",
    "lib/tasks/shop_discounts_extension_tasks.rake",
    "public/javascripts/admin/extensions/shop/discounts/edit.js",
    "public/stylesheets/sass/admin/extensions/shop/discounts/edit.sass",
    "radiant-shop_discounts-extension.gemspec",
    "shop_discounts_extension.rb",
    "spec/controllers/admin/shop/discounts/discountables_controller_spec.rb",
    "spec/controllers/admin/shop/discounts_controller_spec.rb",
    "spec/datasets/forms_discount.rb",
    "spec/datasets/shop_discountables.rb",
    "spec/datasets/shop_discounts.rb",
    "spec/lib/shop_discounts/models/discountable_spec.rb",
    "spec/lib/shop_discounts/models/form_line_item_spec.rb",
    "spec/lib/shop_discounts/models/purchaseable_spec.rb",
    "spec/lib/shop_discounts/tags/item_spec.rb",
    "spec/models/form_discount_spec.rb",
    "spec/models/shop_category_spec.rb",
    "spec/models/shop_discount_spec.rb",
    "spec/models/shop_line_item_spec.rb",
    "spec/models/shop_order_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{https://github.com/thefrontiergroup/radiant-shop_discounts-extension}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Shop Discounts Extension for Radiant CMS}
  s.test_files = [
    "spec/controllers/admin/shop/discounts/discountables_controller_spec.rb",
    "spec/controllers/admin/shop/discounts_controller_spec.rb",
    "spec/datasets/forms_discount.rb",
    "spec/datasets/shop_discountables.rb",
    "spec/datasets/shop_discounts.rb",
    "spec/lib/shop_discounts/models/discountable_spec.rb",
    "spec/lib/shop_discounts/models/form_line_item_spec.rb",
    "spec/lib/shop_discounts/models/purchaseable_spec.rb",
    "spec/lib/shop_discounts/tags/item_spec.rb",
    "spec/models/form_discount_spec.rb",
    "spec/models/shop_category_spec.rb",
    "spec/models/shop_discount_spec.rb",
    "spec/models/shop_line_item_spec.rb",
    "spec/models/shop_order_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<radiant-shop-extension>, [">= 0.92.3"])
    else
      s.add_dependency(%q<radiant-shop-extension>, [">= 0.92.3"])
    end
  else
    s.add_dependency(%q<radiant-shop-extension>, [">= 0.92.3"])
  end
end

