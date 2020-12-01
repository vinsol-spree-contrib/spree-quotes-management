Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_quotes_to_admin_sidebar',
  insert_after: "erb[loud]:contains('t(:configurations)')",
  text: %q{
      <ul class="nav nav-sidebar">
        <%= tab Spree::Quote, url: spree.admin_quotes_path, label: plural_resource_name(Spree::Quote), icon: 'bookmark' %>
      </ul>
    }
)
