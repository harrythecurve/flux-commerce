::INFLUX = InfluxDB2::Client.new('http://localhost:8086', 'SZDf0pLEmNCmAuR8Rj4E9nsHgK-8mH8Ibk_V41lAJptfp7gjzQZ17p4Zy82soTDVkyB-4T7T3xKBHHM-_6LmYA==',
  bucket: 'analytics',
  org: 'FluxCommerce',
  precision: InfluxDB2::WritePrecision::NANOSECOND,
  use_ssl: false,
)

::INFLUX_WRITE_API = INFLUX.create_write_api

::INFLUX_QUERY_API = INFLUX.create_query_api
