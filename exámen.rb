require "uri"
require "net/http"
require "json"

def request(url, api_key="Z5CuehDG6UfLpxQnPyyIDCO2ChxNZF55iGxkgP2d")
    url = URI("#{url}&api_key=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    JSON.parse (response.read_body)
#. Crear el método request que reciba una url y el api_key y devuelva el hash con los resultados.
end

def web_page_nasa(request)
    images = request.map do |filtering|
        filtering['img_src']
    end
    html = "<html>\n<h1> Mars Photos </h1>\n<head>\n</head>\n\t<body>\n\t\t<ul>"
    images.each do |image|
        html += "\n\t\t\t<li><img src='#{image}'width ='700'></li>\n"
    end
    html += "\t\t</ul>\n\t</body>\n</html>"
    return html
#Crear un método que reciba el hash de respuesta con todos los datos y construya una página web.
end

photos = web_page_nasa(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10')["photos"])
File.write('mars_photos.html', photos.to_s)

def photos_count(request)
    camera_name = request.map do |filtering|
        filtering['camera']['name']
    end
    group = camera_name.group_by { |camera_name| camera_name }
    number_photo = group.each do |cam_group, photo_qty|
        group[cam_group] = photo_qty.count
    end
    return number_photo
#Crear un método que reciba el hash de respuesta y devuelva un nuevo hash con el nombre de la camara y la cantidad de fotos
end

print photos_count(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10')["photos"])

