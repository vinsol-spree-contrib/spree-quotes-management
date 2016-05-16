class Spree::QuotesController < Spree::StoreController

  protect_from_forgery with: :null_session

  def index
    @quotes = ::Spree::Quote.where(user: current_spree_user) if current_spree_user
  end

  def create
    @quote = ::Spree::Quote.new(quote_params)
    if @quote.save
      flash.now[:notice] = Spree.t(:valid_quote_message)
      @quote = ::Spree::Quote.new
    end

  end

    private
      def quote_params
        params.require(:quote).permit(:description, :user_id, :author_name)
      end

end
