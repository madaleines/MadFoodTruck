# Food Truck: A SF Food Truck Tracker

A Console Application which utilizes [City of San Francisco's Food Truck API](https://dev.socrata.com/foundry/data.sfgov.org/jjew-r69b) provided by [DataSF](https://datasf.org/opendata/) to list open food trucks at the time of use in the San Francisco area.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development purposes.

### Prerequisites

You can obtain an optional token to make API calls [here](https://dev.socrata.com/docs/app-tokens.html)

(Note: You can still make a limited amount of API calls without obtaining one)

### Installing

* Clone repository
* Install needed gems using the Gemfile
    * run ```bundle install``` in the /FoodTuck directory
* If you obtain your own token, place in a .env file
    * ```TOKEN = "YOUR-TOKEN"```


## Running the CLI

* Run ```ruby main.rb```
* As the first call is made to print results, you may continue by typing 'Y' or 'y'
* Press any other key to exit the program


## Resources Used

* [Socrata Open Data API (SODA)](https://github.com/socrata/soda-ruby) - Socrata's provided Ruby gem to access open data

## Future Features to Implement

* **Edge Case**: Not getting all Open Times filtering through the API request with time filters.
    * Ex. When trucks were open 8pm - 2am and the user checked for available trucks at around 1:30am, they would miss on these open ones due to the current implementation. As filtering would show that the start time (8pm) is  technically not less than the supposed current time (1:30am)
    *  Create a TimeRange class to check for edge cases.
    * Trade off loading less data by loading only with the ```DAY_OF_WEEK``` filter to get more correct information by including any ones that meet the edge case.

* **Web App**:
    * To expand this to a Ruby on Rails MVC based web app, I would:
        * Discard the ```main.rb``` file
        * Create a ```food_truck_controller.rb``` and correlating html view file file which would have an index method calling my SodaApiWrapper class and get_open_trucks(offset) method to display a list of trucks.
        * The pagination would be implemented in the controller
