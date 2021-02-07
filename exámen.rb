require "uri"
require "net/http"
require "json"

def request(url, api_key="Z5CuehDG6UfLpxQnPyyIDCO2ChxNZF55iGxkgP2d")
    url = URI("#{url}&api_key=#{api_key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse (response.read_body)
end

def web_page_nasa(request)
    images = request.map do |filtering|
        filtering['img_src']
    end
    html = "<html>\n<head>\n</head>\n\t<body>\n\t\t<ul>"
    images.each do |image|
        html += "\n\t\t\t<li><img src=#{image}'></li>\n"
    end
    html += "\t\t</ul>\n\t</body>\n</html>"
    return html
end


nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
puts request(nasa_array)
