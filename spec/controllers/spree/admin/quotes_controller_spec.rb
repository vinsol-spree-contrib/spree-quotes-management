require 'spec_helper'

describe Spree::Admin::QuotesController, type: :controller do
  let(:user) { create(:user) }
  let(:quote) { create(:quote) }
  let(:published_quote) { create(:published_quote) }

  before do
    allow(controller).to receive_messages spree_current_user: user
    user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  end

  def do_index
    get :index
  end

  def do_publish(quote)
    get :publish, id: quote.id
  end

  def do_unpublish(quote)
    get :unpublish, id: quote.id
  end

  describe '#index' do
    it 'renders index template' do
      do_index
      expect(response).to render_template(:index)
    end

    it 'sets @quote' do
      do_index
      expect(assigns(:quotes)).to eq([quote])
    end
  end

  describe '#publish' do
    it 'publishes quote' do
      do_publish(quote)
      expect(quote.reload.state).to eq('published')
    end

    it 'redirect_to index page on success' do
      do_publish(quote)
      expect(response).to redirect_to(admin_quotes_path)
    end

    it 'sets notice' do
      do_publish(quote)
      expect(flash[:notice]).to eq(Spree.t('flash.quotes.publish.success'))
    end

    it 'render edit page on failure' do
      allow_any_instance_of(::Spree::Quote).to receive_messages publish: false
      do_publish(quote)
      expect(response).to render_template(:edit)
    end
  end

  describe '#unpublish' do
    it 'unpublishes quote' do
      do_unpublish(published_quote)
      expect(quote.reload.state).to eq('draft')
    end

    it 'redirect_to index page on success' do
      do_unpublish(published_quote)
      expect(response).to redirect_to(admin_quotes_path)
    end

    it 'sets notice' do
      do_unpublish(published_quote)
      expect(flash[:notice]).to eq(Spree.t('flash.quotes.unpublish.success'))
    end

    it 'render edit page on failure' do
      allow_any_instance_of(::Spree::Quote).to receive_messages unpublish: false
      do_unpublish(published_quote)
      expect(response).to render_template(:edit)
    end
  end
end
