class HomeController < ApplicationController
  def index
    @sale_count = Sale.count
    @visitor_count = Visitor.count
  end

  def widget_stats
    render json: { sale_count: Sale.count, visitor_count: Visitor.count }
  end

  def aggregate_dashboard
    visitor_data = Visitor.group_by_day(:created_at).count
    @series = [{name: 'Visitors', data: visitor_data, stroke: 'smooth'}]
    @options = {
      title: {
        text: 'Daily Visitors',
        align: 'Center'
      },
      subtitle: 'Grouped per day',
      xtitle: 'Day',
      ytitle: 'Visitors',
      stacked: true,
      stroke: {
        curve: 'smooth'
      },
      width: '50%',
      chart: {
        fontFamily: "Roboto",
        height: 350,
        type: 'line',
      },
      markers: {
        size: 5,
      },
      grid: {
        row: {
          colors: ['#f3f3f3', 'transparent'],
          opacity: 0.5
        },
      },
    }
  end
end
