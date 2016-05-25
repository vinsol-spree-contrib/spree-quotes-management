module Spree
  module Admin
    class QuotesController < ResourceController
      before_filter :load_quote, only: [:publish, :unpublish]

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
        if @quote.publish
          flash[:notice] = Spree.t('flash.quotes.publish.success')
          redirect_to request.referrer
        else
          render action: :edit
        end
      end

      def unpublish
        if @quote.unpublish
          flash[:notice] = Spree.t('flash.quotes.unpublish.success')
          redirect_to request.referrer
        else
          render action: :edit
        end
      end

      private
        def load_quote
          @quote = Quote.find_by(id: params[:id])
          unless @quote.present?
            flash[:alert] = Spree.t('flash.quotes.state_change.failure')
            redirect_to request.referrer
          end
        end
    end
  end
end
