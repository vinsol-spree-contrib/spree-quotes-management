Spree::Admin::GeneralSettingsController.class_eval do
  before_filter :update_quotes_settings, only: :update

  private

  def update_quotes_settings
    params.each do |name, value|
      next unless SpreeQuotesManagement::Config.has_preference? name
      SpreeQuotesManagement::Config[name] = value
    end
  end
end
