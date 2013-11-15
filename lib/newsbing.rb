require 'json'
require 'open-uri'
require 'net/http'
# Before proceeding you will need an account key, which can be obtained by registering an accout at http://windows.microsoft.com/en-US/windows-live/sign-in-what-is-microsoft-account
class Newssearch 
	# Create a new object of the bing class
	#   >> bing = Bing.new('your_account_key_goes_here', 10) 
	#   => #<Bing:0x9d9b9f4 @account_key="your_account_key", @num_results=10>
	# Arguments:
	#   account_key: (String)
	#   num_results: (Integer)

	def initialize(account_key, num_results)
		@account_key = account_key
		@num_results = num_results
	end

	attr_accessor :account_key, :num_results

	def search(search_term )
          results = []
          offset = 15 # MS SPECIFIC CONSTANT
	  modulus = @num_results % offset
          results = []
          skip = 0
	    until @num_results < offset
		results << hit_api(search_term, skip, offset)
		@num_results = @num_results - offset
                skip = skip + offset
	    end
          results << hit_api(search_term, skip, modulus) 
          return results.flatten




        end

	def hit_api(search_term, skip, top)
		  user = ''
		  result_set = []
  		  web_search_url = "https://api.datamarket.azure.com/Bing/Search/v1/News?"
		  query_string = '$format=json&Query='
		  query_portion = URI.encode_www_form_component('\'' + search_term + '\'')
		  params = "&$top=#{top.to_s}&$skip=#{skip}"
		  full_address = web_search_url + query_string + query_portion + params
		  uri = URI(full_address)
		  req = Net::HTTP::Get.new(uri.request_uri)
		  req.basic_auth user, account_key

		  res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
  		  	  http.request(req)
		  }
		  body = JSON.parse(res.body)
		  result_set = body["d"]["results"]	
		  
	end	
end
