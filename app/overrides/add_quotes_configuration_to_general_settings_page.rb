Deface::Override.new(
  virtual_path: 'spree/admin/general_settings/edit',
  name: 'add_quotes_configuration_to_admin_general_settings',
  insert_after: "#preferences .panel.currency",
  partial: 'spree/shared/add_quotes_configuration_to_admin_general_settings',
  disabled: false
)
