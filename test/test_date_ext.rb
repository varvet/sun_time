require "test/unit"

require File.expand_path(File.join(File.dirname(__FILE__), "../lib/sun_time/date_ext"))

class TestDate < Test::Unit::TestCase
  def setup
    @lat = 57.7119
    @lng = 11.9683
    @date = Date.new(2009, 7, 23)
  end
  
  def test_sunrise
    sunrise = Time.utc(2009, 7, 23, 2, 50, 32)
    assert_equal(sunrise, @date.sunrise(@lat, @lng))
  end
  
  def test_sunset
    sunset =  Time.utc(2009, 7, 23, 19, 48, 56)
  
    assert_equal(sunset, @date.sunset(@lat, @lng))
  end
end
