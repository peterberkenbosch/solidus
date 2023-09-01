# frozen_string_literal: true

require 'spree_core'

class Arel::Table
  def table_name
    name
  end
end
