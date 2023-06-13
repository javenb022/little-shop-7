class Photo
  attr_reader :url, :data, :likes

  def initialize(data)
    @url = data[:urls][:thumb]
    @data = data
    @likes = data[:likes]
  end
end