module Spree
  class Quote < Spree::Base

    # Scopes
    scope :published, -> { where(state: 'published') }
    scope :ranked_quotes, -> { published.where(rank: rank_range) }
    scope :published_and_without_rank, -> { published.where(arel_table[:rank]
                                                    .not_in(rank_range)
                                                    .or(arel_table[:rank].eq(nil))) }

    delegate :email, to: :user, prefix: true

    # Validations
    validates :description, :user, :state, presence: true
    validates_numericality_of :rank, less_than_or_equal_to: :quotes_display_count, greater_than: 0,
                                      allow_blank: true

    #Associations
    belongs_to :user

    #Callbacks
    before_update :update_quotes_of_same_rank, if: :rank_changed?
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
      1..quotes_display_count
    end

    def self.quotes_display_count
      ::SpreeQuotesManagement::Config[:quotes_count]
    end

    def self.top_quotes
      # get quotes with rank
      top_quotes = ranked_quotes.order(rank: :desc).to_a

      # get random quotes
      random_quotes_count = quotes_display_count - top_quotes.count
      random_quotes = published_and_without_rank.sample(random_quotes_count)

      #arrange quotes
      top_quotes = rank_range.to_a.reduce([]) do |quotes, rank|
        quote = top_quotes.last.try(:rank) == rank ? top_quotes.pop : random_quotes.pop
        quote ? quotes << quote : quotes
      end
    end


    private

      def quotes_display_count
        self.class.quotes_display_count
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
