module Spree
  class Quote < Spree::Base

    scope :published, ->{ where(state: 'published') }
    scope :with_rank, ->{ published.where(rank: rank_range) }
    scope :published_and_without_rank, ->{ published.where(arel_table[:rank].not_in(rank_range).or(arel_table[:rank].eq(nil))) }

    delegate :email, to: :user, prefix: true

    validates :description, :user, :state, presence: true

    validates_numericality_of :rank, less_than_or_equal_to: :top_quotes_count, greater_than: 0, allow_blank: true

    belongs_to :user

    before_update :update_quotes_of_same_rank, if: -> { rank_changed? }
    before_destroy :restrict_if_published

    state_machine initial: :draft do

      before_transition to: :published, do: :set_published_at
      before_transition to: :draft, do: :reset_rank

      state :draft do
        transition to: :published, on: :publish
      end

      state :published do
        transition to: :draft, on: :unpublish
      end
    end
    self.whitelisted_ransackable_associations = %w[user]
    self.whitelisted_ransackable_attributes = %w[description state author_name]

    def self.rank_range
      1..top_quotes_count
    end

    def self.top_quotes_count
      ::SpreeQuotesManagement::Config[:quotes_count]
    end

    private

      def top_quotes_count
        self.class.top_quotes_count
      end

      def restrict_if_published
        if published?
          errors.add(:Base, Spree.t(:destroy_published_quote))
          false
        end
      end

      def set_published_at
        self.published_at = Time.current
      end

      def reset_rank
        self.rank = nil
      end

      def update_quotes_of_same_rank
        Spree::Quote.where(rank: rank).update_all(rank: nil)
      end
  end
end
