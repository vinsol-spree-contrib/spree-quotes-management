module Spree
  class Quote < Spree::Base
    STATUS = { "Draft" => 0, "Publish" => 1 }

    validates :description, :user, :state, presence: true

    belongs_to :user

  end
end
