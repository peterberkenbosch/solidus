# Financial transaction entry for a specific `store_credit`
module Spree
  class StoreCreditLedgerEntry < Spree::Base
    belongs_to :store_credit
    belongs_to :originator, polymorphic: true

    scope :chronological, -> { order(:created_at) }
    scope :reverse_chronological, -> { order(created_at: :desc) }

    delegate :currency, to: :store_credit

    class << self
      # Needed for legacy store_credit entries so we can record
      # the correct ledger entries based on the events on this store credit
      def generate_ledger_entries_for(store_credit)
        store_credit.store_credit_events.find_each do |store_credit_event|
          ledger_actions = [
            Spree::StoreCredit::CREDIT_ACTION,
            Spree::StoreCredit::CAPTURE_ACTION,
            Spree::StoreCredit::ALLOCATION_ACTION,
            Spree::StoreCredit::ADJUSTMENT_ACTION,
            Spree::StoreCredit::INVALIDATE_ACTION,
          ]

          action = store_credit_event.action
          next unless ledger_actions.include?(action)
          amount = store_credit_event.amount
          # TODO check if this amount should be negative.

          Spree::StoreCreditLedgerEntry.create!(
            {
              amount: amount,
              created_at: store_credit_event.created_at,
              store_credit_id: store_credit.id,
              originator: store_credit_event.originator
            }
          )
        end
      end
    end
  end
end
