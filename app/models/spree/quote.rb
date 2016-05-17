module Spree
  class Quote < Spree::Base

    delegate :email, to: :user, prefix: true

    validates :description, :user, :state, presence: true

    validates_numericality_of :rank, less_than_or_equal_to: SpreeQuotesManagement::Config[:quotes_count], greater_than: 0, allow_blank: true

    belongs_to :user

    before_update :update_quotes_of_same_rank, if: -> { rank_changed? }
    before_destroy :restrict_if_published

    state_machine initial: :draft do

      before_transition to: :published, do: :set_published_at
      before_transition to: :draft, do: :set_rank

      state :draft do
        transition to: :published, on: :publish
      end

      state :published do
        transition to: :draft, on: :unpublish
      end
    end
    self.whitelisted_ransackable_associations = %w[user]
    self.whitelisted_ransackable_attributes = %w[description state author_name]

    private

      def restrict_if_published
        if published?
          errors.add(:Base, Spree.t(:destroy_published_quote))
          false
        end
      end

      def set_published_at
        self.published_at = Time.current
      end

      def set_rank
        self.rank = nil
      end

      def update_quotes_of_same_rank
        Spree::Quote.where(rank: rank).update_all(rank: nil)
      end
  end
end
