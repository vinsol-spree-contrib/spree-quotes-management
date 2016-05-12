module Spree
  class Quote < Spree::Base

    ADMIN_QUOTES_PER_PAGE = 12
    validates :description, :user, :state, presence: true

    belongs_to :user

    state_machine initial: :draft do

      state :draft do
        transition to: :publish, on: :publish
      end

      state :publish do
        transition to: :draft, on: :unpublish
      end
    end

    self.whitelisted_ransackable_attributes = %w[description state]

  end
end
