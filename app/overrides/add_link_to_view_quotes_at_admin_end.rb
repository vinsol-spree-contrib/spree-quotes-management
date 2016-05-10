Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'add_quotes_to_admin_sidebar',
  insert_bottom: "[data-hook='admin_tabs']",
  text: %q{
      <ul class="nav nav-sidebar">
        <%= tab Spree::Quote, url: spree.admin_quotes_path, label: plural_resource_name(Spree::Quote), icon: 'bookmark' %>
      </ul>
    }
)

