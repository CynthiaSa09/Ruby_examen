require "uri"
require "net/http"
require "json"


def request(url, apy_key="Z5CuehDG6UfLpxQnPyyIDCO2ChxNZF55iGxkgP2d")
    url = URI("#{url}&api_key=#{api_key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse (response.read_body)
end
    

response = http.request(request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
puts response.read_body 