require File.expand_path(File.join(File.dirname(__FILE__), "../sun_time"))

class Date
  def sunrise(lat, lng)
    SunTime.new(self, lat, lng).sunrise
  end
  
  def sunset(lat, lng)
    SunTime.new(self, lat, lng).sunset
  end
end