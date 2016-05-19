require 'spec_helper'

describe Spree::QuotesController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive_messages :spree_current_user => user
    user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  end

  def do_create
    xhr :post, :create, quote: { description: 'abc', author_name: 'xyz', user_id: user.id }
  end

  describe '#create' do

    it 'sets notice' do
      do_create
      expect(flash.notice).to eq(Spree.t(:valid_quote_message))
    end

    it 'renders create' do
      do_create
      expect(response).to render_template(:create)
    end
  end

end
