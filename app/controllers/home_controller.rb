class HomeController < ApplicationController
  def index
    @sale_count = Sale.count
    @visitor_count = Visitor.count
  end

  def widget_stats
    render json: { sale_count: Sale.count, visitor_count: Visitor.count }
  end

  def aggregate_dashboard
    # Format of {date => visitor count, date => visitor count}
    visitor_data = Visitor.where('created_at >= ?', 29.days.ago.beginning_of_day).group_by_day(:created_at).count
    sales_data = Sale.where('created_at >= ?', 29.days.ago.beginning_of_day).group_by_day(:created_at).count

    @series = [
      {name: 'Visitors', data: visitor_data, stroke: 'smooth'},
      {name: 'Sales', data: sales_data, stroke: 'smooth'}
    ]

    options
  end

  def influx_dashboard
    visitor_data = get_visitors_from_influx
    sales_data = get_sales_from_influx
    @series = [
      {name: 'Visitors', data: visitor_data, stroke: 'smooth'},
      {name: 'Sales', data: sales_data, stroke: 'smooth'}
    ]

    options
  end

  private

  def options
    @options = {
      chart: {
        type: 'line',
        fontFamily: "Roboto",
        height: 350,
        toolbar: false,
        background: '#fff',
        stacked: false
      },
      stroke: {
        curve: 'smooth'
      },
      fill: {
        type: 'solid',
        opacity: 1,
      },
      xaxis: {
        labels: {
          show: false
        },
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        },
      },
      yaxis: {
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        },
        labels: {
          style: {
            colors: '#78909c'
          }
        }
      },
      title: {
        text: 'Daily Visitors',
        align: 'Center'
      },
      xtitle: 'Day',
      ytitle: 'Count',
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

  def get_visitors_from_influx
    query = <<-FLUX
      from(bucket: "analytics")
        |> range(start: -30d)
        |> filter(fn: (r) => r["_measurement"] == "daily_visitors")
        |> filter(fn: (r) => r["_field"] == "visitors")
        |> sort(columns: ["_time"])
    FLUX

    stream = INFLUX_QUERY_API.query_stream(query: query)

    data = {}

    stream.each do |record|
      date = record.values['_time'].to_date
      puts '#' * 100
      puts date
      puts '#' * 100
      data[date] = record.values['_value'].to_i
    end

    data
  end

  def get_sales_from_influx
    empty_array
  end

  def empty_array
    data = {}
    30.times do |i|
      p i
      days_ago = 29 - i
      data[days_ago.days.ago.to_date] = 0
    end

    data
  end
end
