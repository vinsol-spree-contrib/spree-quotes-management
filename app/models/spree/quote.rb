module Spree
  class Quote < Spree::Base

    delegate :formatted_created_at, to: :decorate
    validates :description, :user, :state, presence: true

    belongs_to :user

    state_machine initial: :draft do

      state :draft do
        transition to: :publish, on: :publish
      end

      state :publish do
        validates_presence_of :rank
        transition to: :draft, on: :unpublish
      end

    end

  end
end
