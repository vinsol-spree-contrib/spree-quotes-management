module Spree
  module Admin
    class QuotesController < ResourceController

      def index
        @quotes = ::Spree::Quote.order(:rank, :updated_at) if current_spree_user
      end

    end
  end
end
