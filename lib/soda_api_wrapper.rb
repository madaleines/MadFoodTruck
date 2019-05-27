require 'soda/client'
require 'date'

require_relative 'food_truck'

class SodaApiWrapper
  DOMAIN = "data.sfgov.org"
  TOKEN = ENV["TOKEN"]
  DATASET_ID = "jjew-r69b"

  # Using numerical value of week day in case weekday name is in diff lang
  DAY_OF_WEEK = Date.today.wday
  CURRENT_TIME = Time.now.strftime("%H:%M")

  def initialize
    # initialize client once to be used as often as needed
    @client = SODA::Client.new({:domain => DOMAIN, :app_token => TOKEN})
  end

  def get_open_trucks(offset)
    query_object = {}

    # TODO Won't catch edge case regarding closing time after midnight
    # Edge case: start24 8pm, end24 2am, start24 is not < a current time of 1:30am
    query_object["$where"] = "dayorder = '#{DAY_OF_WEEK}' AND start24 < '#{CURRENT_TIME}' AND end24 > '#{CURRENT_TIME}'"
    query_object["$limit"] = DEFAULT_LIMIT
    query_object["$offset"] = offset
    query_object["$order"] = "applicant"

    response = @client.get(DATASET_ID, query_object)
    raise_on_error(response)

    results = response.body

    # Parse thru results to return instances of each food truck
    food_trucks = results.map do |result|
      truck_data = {}

      truck_data[:name] = result["applicant"]
      truck_data[:address] = result["location"]

      FoodTruck.new(truck_data)
    end
    return food_trucks
  end

  private
  
  class NoTrucksError < StandardError; end

  def raise_on_error(response)
    if response.code != "200"
      raise SodaApiError.new("Unable to process your search at this time. Got #{response.code}: #{response.message}")
    end
  end
end
