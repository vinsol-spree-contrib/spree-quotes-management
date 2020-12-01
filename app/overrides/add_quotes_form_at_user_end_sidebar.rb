Deface::Override.new(
  virtual_path: 'spree/homer/index',
  name: 'add_quotes_to_user_sidebar',
  insert_after: "[data-product-carousel-taxon-id='trending']",
  partial: 'spree/shared/add_quotes_to_user_sidebar'
)

