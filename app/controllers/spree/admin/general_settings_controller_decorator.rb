Spree::Admin::GeneralSettingsController.class_eval do
  before_action :update_quotes_settings, only: :update

  private

  def update_quotes_settings
    SpreeQuotesManagement::Config.defined_preferences.each do |preference|
      SpreeQuotesManagement::Config[preference] = params[preference] if params[preference]
    end
  end
end
