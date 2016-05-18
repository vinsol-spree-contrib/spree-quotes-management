module Spree
  module Admin
    class QuotesController < ResourceController

      def index
        @quotes = ::Spree::Quote.order(::Spree::Quote.arel_table[:rank].eq(nil), :rank, created_at: :desc)
        params[:q] ||= {}
        @search = @quotes.ransack(params[:q])
        @quotes = @search.result.
              includes(:user).
              page(params[:page]).
              per(params[:per_page] || SpreeQuotesManagement::Config[:admin_quotes_per_page])

      end

      def publish
        @quote = Quote.find_by(id: params[:id])
        if @quote.publish
          flash[:notice] = Spree.t('flash.quotes.publish.success')
          redirect_to admin_quotes_path(q: params[:q])
        else
          render action: :edit
        end
      end

      def unpublish
        @quote = Quote.find_by(id: params[:id])
        if @quote.unpublish
          flash[:notice] = Spree.t('flash.quotes.unpublish.success')
          redirect_to admin_quotes_path(q: params[:q])
        else
          render action: :edit
        end
      end

    end
  end
end
