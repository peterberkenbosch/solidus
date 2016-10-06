# Financial transaction entry for a specific `store_credit`
module Spree
  class StoreCreditLedgerEntry < Spree::Base
    belongs_to :store_credit
  end
end
