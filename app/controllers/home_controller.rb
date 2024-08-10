class HomeController < ApplicationController
  def index
    @sale_count = Sale.count
    @visitor_count = Visitor.count
  end

  def widget_stats
    render json: { sale_count: Sale.count, visitor_count: Visitor.count }
  end
end
