module ApplicationHelper
  def cache_key_for_stock(stock)
    "stock-#{stock.updated_at}"
  end
  def cache_key_for_stock_list
    "stock-list-#{Stock.maximum(:updated_at)}-#{Stock.maximum(:created_at)}"
  end
end
