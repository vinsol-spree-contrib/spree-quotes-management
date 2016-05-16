module Spree
  class Quote < Spree::Base

    QUOTE_DESCRIPTION_MAX_LIMIT = 240

    validates :description, :user, :state, presence: true

    belongs_to :user

    before_destroy :restrict_if_published

    state_machine initial: :draft do

      before_transition to: :published, do: :set_published_at

      state :draft do
        transition to: :published, on: :publish
      end

      state :published do
        transition to: :draft, on: :unpublish
      end
    end

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
  end
end
