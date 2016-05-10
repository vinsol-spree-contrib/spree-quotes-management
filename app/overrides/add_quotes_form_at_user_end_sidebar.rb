Deface::Override.new(
  virtual_path: 'spree/home/index',
  name: 'add_quotes_to_user_sidebar',
  insert_bottom: "[data-hook='homepage_sidebar_navigation']",
  partial: 'spree/shared/add_quotes_to_user_sidebar'
)

