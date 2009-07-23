class Date
  def sunrise(lat, lng)
    SunTime.new(self, lat, lng).sunrise
  end
  
  def sunset(lat, lng)
    SunTime.new(self, lat, lng).sunset
  end
end