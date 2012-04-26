require "test/unit"

require File.expand_path(File.join(File.dirname(__FILE__), "../lib/sun_time"))

class TestSunTime < Test::Unit::TestCase
  def setup
    @lat = 57.7119
    @lng = 11.9683
    @date = Date.new(2009, 7, 23)
    @sun_time = SunTime.new(@date, @lat, @lng)
  end
  
  def test_sunrise
    sunrise = Time.utc(2009, 7, 23, 2, 50, 32)
    
    assert_equal(sunrise, @sun_time.sunrise)
  end
  
  def test_sunset
    sunset =  Time.utc(2009, 7, 23, 19, 48, 56)
  
    assert_equal(sunset, @sun_time.sunset)
  end
  
  def test_always_light
    summer_in_sweden = SunTime.new(Date.new(2009,6,22), 67.8529, 20.2426)
    assert_nil(summer_in_sweden.sunrise)
    assert_nil(summer_in_sweden.sunset)
  end
  
  def test_always_dark
    winter_in_sweden = SunTime.new(Date.new(2009,12,22), 67.8529, 20.2426)
    assert_nil(winter_in_sweden.sunrise)
    assert_nil(winter_in_sweden.sunset)
  end

  def test_infinite_loop
    sunrise = Time.utc(2012, 4, 24, 10, 4, 51)
    infinite_loop_location = SunTime.new(Date.new(2012,4,24), 40.9674702, -74.2278852)
    assert_equal(sunrise, infinite_loop_location.sunrise)
  end
  
  # Private methods
  
  def test_j_date
    assert_equal(2455036, @sun_time.send(:j_date))
  end
  
  def test_n
    assert_equal(3491, @sun_time.send(:n))
  end
  
  def test_j_star
    assert_in_delta(2455035.9676547, @sun_time.send(:j_star), 2 ** -20)
  end
  
  def test_m
    assert_in_delta(198.22779796522, @sun_time.send(:m), 2 ** -20)
  end
  
  def test_c
    assert_in_delta(-0.58730215027404, @sun_time.send(:c), 2 ** -20)
  end
  
  def test_sun_l
    assert_in_delta(120.57769581495, @sun_time.send(:sun_l), 2 ** -20)
  end
  
  def test_j_transit
    assert_in_delta(2455035.9720408, @sun_time.send(:j_transit), 2 ** -20)
  end
  
  def test_sun_d
    assert_in_delta(20.03506338786, @sun_time.send(:sun_d), 2 ** -20)
  end
  
  def test_h
    assert_in_delta(127.29871041684, @sun_time.send(:h), 2 ** -20)
  end
  
  def test_j_set
    assert_in_delta(2455036.3256485, @sun_time.send(:j_set), 2 ** -20)
  end
  
  def test_j_rise
    assert_in_delta(2455035.6184334, @sun_time.send(:j_rise), 2 ** -20)
  end
end
