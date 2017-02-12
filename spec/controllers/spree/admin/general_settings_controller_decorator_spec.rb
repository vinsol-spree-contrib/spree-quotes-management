require 'spec_helper'

describe Spree::Admin::GeneralSettingsController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive_messages spree_current_user: user
    user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  end

  def do_update
    post :update, params: { disable_quote: true, quotes_count: 10, store: { url: 'www.spree.com' } }
  end

  describe '#update' do

    it 'sets preference disable_quote' do
      do_update
      expect(SpreeQuotesManagement::Config[:disable_quote]).to be true
    end

    it 'sets preference quotes_count' do
      do_update
      expect(SpreeQuotesManagement::Config[:quotes_count]).to eq(10)
    end
  end

end
