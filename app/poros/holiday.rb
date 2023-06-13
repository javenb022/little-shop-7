class Holiday
  attr_reader :date1,
              :date2,
              :date3,
              :name1,
              :name2,
              :name3

  def initialize(data)
    @date1 = data[0][:date]
    @date2 = data[1][:date]
    @date3 = data[2][:date]
    @name1 = data[0][:name]
    @name2 = data[1][:name]
    @name3 = data[2][:name]
  end
end 