class PhotoService
  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def app_logo
    get_url("https://api.unsplash.com/photos/e3-WdkIYZGM?client_id=41FnloUJRwgHF3waPM704zSuS0VEAEtJDWpC1rvd8uQ")
  end

  def item(item_name)
    get_url("https://api.unsplash.com/photos/random?client_id=41FnloUJRwgHF3waPM704zSuS0VEAEtJDWpC1rvd8uQ&query=#{item_name}")
  end

  def merchant(merchant_name)
    get_url("https://api.unsplash.com/photos/random?client_id=41FnloUJRwgHF3waPM704zSuS0VEAEtJDWpC1rvd8uQ&query=#{merchant_name}")
  end
end
