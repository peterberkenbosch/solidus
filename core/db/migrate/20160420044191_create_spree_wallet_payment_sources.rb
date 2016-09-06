class CreateSpreeWalletPaymentSources < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_wallet_payment_sources do |t|
      t.references :user, index: true, null: false
      t.references :payment_source, polymorphic: true, null: false
      t.boolean :default, default: false, null: false

      t.timestamps null: false
    end

    add_index(
      :spree_wallet_payment_sources,
      [:user_id, :payment_source_id, :payment_source_type],
      unique: true,
      name: 'index_spree_wallet_payment_sources_on_source_and_user',
    )
  end
end