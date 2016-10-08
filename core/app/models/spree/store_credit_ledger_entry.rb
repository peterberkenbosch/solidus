# Financial transaction entry for a specific `store_credit`
module Spree
  class StoreCreditLedgerEntry < Spree::Base
    belongs_to :store_credit

    scope :chronological, -> { order(:created_at) }
    scope :reverse_chronological, -> { order(created_at: :desc) }

    delegate :currency, to: :store_credit
  end
end
