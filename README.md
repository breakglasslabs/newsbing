A gem to sanely interact with the News portion of the Bing API. Based on the search bing gem.
-------------
find the [gem](https://rubygems.org/gems/newsbing) on rubygems.org



## Installation
    gem install newsbing


Configuration
-------------
An account key is needed to use the Bing Search API. You can create a new account for the Bing Search API and obtain account key [here](http://www.bing.com/developers/)

## Usage

- this gem relies on the open-uri, net/http, and json gems.

- Bing News results are limited to 15 returned results for every API call; this gem will use skip and top to get as many results as needed, note that for every 15 results your num_results parameter is, Microsoft will "charge" you 1 API call.

Example: Interactive Ruby Shell
----------
require the gem in your shell session

   	require 'newsbing'

        num_results = 100

	bing = Newssearch.new('your_account_key_goes_here', num_results)

retrieve the results for a given term

	results = bing.search("linux")


parse the results
 
	puts results[0]["Url"] # puts url of result
