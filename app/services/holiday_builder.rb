require "./app/services/holiday_service"
require "./app/poros/holiday"

class HolidayBuilder
  def self.service
    HolidayService.new
  end

  def self.holiday_info
    Holiday.new(service.holidays)
  end
end