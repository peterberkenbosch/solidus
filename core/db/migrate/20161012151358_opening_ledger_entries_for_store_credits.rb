class OpeningLedgerEntriesForStoreCredits < ActiveRecord::Migration[5.0]
  def change
    Spree::StoreCredit.find_each do |store_credit|
      Spree::StoreCreditLedgerEntry.generate_ledger_entries_for(store_credit)
    end
  end
end
