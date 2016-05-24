# Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
#
# Example adding this to your spec_helper will load these Factories for use:
# require 'spree_quotes_management/factories'
FactoryGirl.define do
  factory :quote, :class => Spree::Quote do
    description { Faker::Lorem.sentence }
    user
    trait :published do
      state 'published'
      published_at { Time.current }
    end
    factory :published_quote, traits: [:published]
  end

end
