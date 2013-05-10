require 'spec_helper'

describe "Shipments" do
  stub_authorization!

  let!(:order) { create(:order_ready_to_ship, :number => "R100", :state => "complete") }

  context "shipping an order", js: true do
    before(:each) do
      visit spree.admin_path
      click_link "Orders"
      within_row(1) do
        click_link "R100"
      end
    end

    it "can ship a completed order" do
      click_link "ship"
      sleep 1

      page.should have_content("SHIPPED PACKAGE")
      order.reload.shipment_state.should == "shipped"
    end
  end

  context "moving variants between shipments", js: true do
    let!(:la) { create(:stock_location, name: "LA") }
    before(:each) do
      create(:stock_location, name: "LA")
      visit spree.admin_path
      click_link "Orders"
      within_row(1) do
        click_link "R100"
      end
    end

    it "can move a variant to a new shipment" do
      page.all("table.stock-contents").count.should == 1
      within_row(1) do
        click_icon 'resize-horizontal'
      end
      select2_no_label 'LA', from: 'Choose Location'
      click_icon :ok

      page.all("table.stock-contents").count.should == 2
      order.shipments.last.stock_location.should == la
      order.shipments.last.inventory_units.count.should == 1
    end

    it "can move a variant to an existing shipment" do
      page.all("table.stock-contents").count.should == 1
      within_row(1) do
        click_icon 'resize-horizontal'
      end
      select2_no_label 'LA', from: 'Choose Location'
      click_icon :ok
<<<<<<< HEAD

      within_row(1) do
        click_icon 'resize-horizontal'
      end
      select2_no_label "LA(#{order.reload.shipments.last.number})", from: 'Choose Location'
      click_icon :ok

      page.all("table.stock-contents").count.should == 2
      order.shipments.last.stock_location.should == la
      order.shipments.last.inventory_units.count.should == 2
=======
      page.should have_selector("table.stock-contents:eq(2)")

      within_row(2) { click_icon 'resize-horizontal' }
      targetted_select2 "LA(#{order.reload.shipments.last.number})", from: '#s2id_item_stock_location'
      click_icon :ok
      page.should have_selector("table.stock-contents:eq(2)")
>>>>>>> Fix build specs and split shipment edit button [Fixes #3167]
    end
  end
end
