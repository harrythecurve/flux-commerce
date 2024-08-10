::INFLUX = InfluxDB2::Client.new('http://localhost:8086', 'fhsmultinet2024',
  bucket: 'flux-commerce',
  org: 'freedomhotspot',
  precision: InfluxDB2::WritePrecision::NANOSECOND,
  use_ssl: false,
)

::INFLUX_WRITE_API = INFLUX.create_write_api

::INFLUX_QUERY_API = INFLUX.create_query_api
