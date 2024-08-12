# README

Before running this project, you will need a working setup of [InfluxDB](https://docs.influxdata.com/influxdb/v2/install/?t=Linux)

1. Run InfluxDB with `sudo service influxdb start`
2. You can access the GUI at port 8086: http://localhost:8086/
3. Install the gemfiles `bundle install`
4. Run the server `rails server`
5. Configure the database.yml file
6. Create the database `rails db:create`
7. Run the migrations `rails db:migrate`
8. Configure the `influx.rb` initializer
  8a. From the Influx GUI, you can create an account
  8b. Once logged in, you will need an organization which you can create (there should be a drop-down button at the side towards the top)
  8c. Name the bucket something like "analytics"
  8d. Once you have an organization, you will want a token for the rails project. Find the drop down with the API tokens link
  8e. From here, generate a token (All access) and copy it into the Influx initializer
9. You may need to restart the rails server for the changes to take effect
10. Run the seeder to add data to the database and Influx `rails db:seed`

# Test Influx is configured correctly

1. Enter the rails console `rails c`
2. Run the command `INFLUX.health`
3. The message should return "ready for queries and writes"

# Exercise

Now that you have the application running, try to get the sales data configured in Influx and queried into the line graph. Use the visitors data as an example.
