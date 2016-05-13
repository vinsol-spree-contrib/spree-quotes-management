module Spree
  class Quote < Spree::Base

    validates :description, :user, :state, presence: true

    belongs_to :user

    before_destroy :check_if_published

    state_machine initial: :draft do

      before_transition on: :publish, do: :set_date_of_publish

      state :draft do
        transition to: :publish, on: :publish
      end

      state :publish do
        transition to: :draft, on: :unpublish
      end
    end

    private

      def check_if_published
        if publish?
          errors.add(:Base, Spree.t(:destroy_published_quote))
          false
        end
      end

      def set_date_of_publish
        self.published_at = Time.now
      end
  end
end
