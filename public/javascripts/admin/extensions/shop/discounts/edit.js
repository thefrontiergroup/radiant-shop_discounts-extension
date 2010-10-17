/* <li
     class="discountable product" || class="discountable discounted"
     id="product_1"
     data-discounted_type_human="Product"
     data-discounted_id="1"
     data-discounted_type="ShopProduct"
     data-success_element="discount_products"
   />
*/

document.observe("dom:loaded", function() {
  shop_discount_edit = new ShopDiscountEdit();
  shop_discount_edit.initialize();
  
  Event.addBehavior({
    '.discountable.available:click':          function(e) { shop_discount_edit.discountedAttach($(this)) },
    '.discountable.discounted .delete:click': function(e) { shop_discount_edit.discountedRemove($(this)) },
  })
});

var ShopDiscountEdit = Class.create({
  
  initialize: function() {
  },
  
  discountedAttach: function(element) {
    var route   = shop.getRoute('admin_shop_discount_discountables_path');
    
    showStatus('Adding '+element.getAttribute('data-discounted_type_human')+'...');
    new Ajax.Request(route, {
      method: 'post',
      parameters: {
        'discounted_id':   element.getAttribute('data-discounted_id'),
        'discounted_type': element.getAttribute('data-discounted_type'),
      },
      onSuccess: function(data) {
        $(element.getAttribute('data-success_element')).insert({ 'bottom' : data.responseText});
        shop_discount_edit.postChanges(element);
      }.bind(element),
      onFailure: function() {
        shop_discount_edit.errorStatus();
      }
    });
  },
  
  discountedRemove: function(element) {
    var element         = element.up('.discounted');
    var discountable_id = element.readAttribute('data-discountable_id');
    var route           = shop.getRoute('admin_shop_discount_discountable_path', 'js', discountable_id);
    
    showStatus('Removing '+element.getAttribute('data-discounted_type_human')+'...');
    element.hide();
    new Ajax.Request(route, { 
      method: 'delete',
      onSuccess: function(data) {
        $(element.getAttribute('data-success_element')).insert({ 'bottom' : data.responseText });
        shop_discount_edit.postChanges(element);
      },
      onFailure: function(data) {
        shop_discount_edit.errorStatus();
      }
    });
  },
  
  postChanges: function(element) {
    element.remove();
    
    hideStatus();
  },
  
  errorStatus: function() {
    setStatus('Something went wrong, refreshing.');
    location.reload(true);
  }
  
});