module Spree
  module Admin
    class QuotesController < ResourceController

      def index
        @quotes = ::Spree::Quote.order('rank desc, updated_at desc')
        params[:q] ||= {}
        @search = @quotes.ransack(params[:q])
        @quotes = @search.result.
              includes(:user).
              page(params[:page]).
              per(params[:per_page] || Spree::Quote::ADMIN_QUOTES_PER_PAGE)

      end

      def publish
        @quote = Quote.find_by(id: params[:id])
        if @quote.publish
          flash[:notice] = 'Quote successfully published'
          redirect_to admin_quotes_path(q: params[:q])
        else
          render action: :edit
        end
      end

      def unpublish
        @quote = Quote.find_by(id: params[:id])
        if @quote.unpublish
          flash[:notice] = 'Quote successfully unpublished'
          redirect_to admin_quotes_path(q: params[:q])
        else
          render action: :edit
        end
      end

    end
  end
end
