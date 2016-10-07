require 'spec_helper'

describe Spree::StoreCreditLedgerEntry do
  let!(:store_credit) { build(:store_credit, amount: 250) }

  it "will be created on store_credit creation" do
    expect{store_credit.save}.to change {store_credit.store_credit_ledger_entries.count}.by 1
  end

  it "will have an opening balance equal to the amount created" do
    store_credit.save
    expect(store_credit.ledger_balance).to eql 250
  end

  # actions:

  # init
  # manually update (+ / -)!
  # capture
  # invalidate
  # destroy?


end
