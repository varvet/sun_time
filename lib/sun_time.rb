require 'date'

require File.expand_path(File.join(File.dirname(__FILE__), "sun_time/degree_trig"))

class SunTime
  VERSION = '0.0.2'
  MEAN_SOLAR_ANOMALY_DELTA = 0.000001
  
  class AlwaysDarkError < ::StandardError; end
  class AlwaysLightError < ::StandardError; end
  
  attr_reader :date, :lat, :lng
  
  def initialize (date, lat, lng)
    @date = date
    @lat = lat
    @lng = lng
    @m = nil
  end
  
  def sunrise
    jd2time j_rise
  rescue AlwaysDarkError, AlwaysLightError
    nil
  end
  
  def sunset
    jd2time j_set
  rescue AlwaysDarkError, AlwaysLightError
    nil
  end
    
private
  include DegreeTrig
  
  # Julian date
  def j_date
    date.jd
  end
  
  # West longitude
  def lng_w
    lng * -1
  end
  
  # North latitude
  def lat_n
    lat
  end
  
  # Mean solar anomaly
  def m(_j_transit=j_star)
    (357.5291 + 0.98560028 * (_j_transit - 2451545)) % 360
  end
  
  # Julian cycle since Jan 1, 2000
  def n
    ((j_date.to_f - 2451545 - 0.0009) - (lng_w/360)).round
  end
  
  # Equation of center
  def c(_m=m)
    1.9148*sin(_m) + 0.0200*sin(2*_m) + 0.0003*sin(3*_m)
  end
  
  # Ecliptical longitude of the sun
  def sun_l
    _m = @m || m
    c = c(_m)
    (_m + 102.9372 + c + 180) % 360
  end
  
  # Declination of the sun
  def sun_d
    recalculate_m
    asin(sin(sun_l) * sin(23.45))
  end
  
  # Hour angle (half the arc length of the sun)
  def h
    i = (sin(-0.83) - sin(lat_n) * sin(sun_d)) / (cos(lat_n) * cos(sun_d))
    
    if i < -1.0
      raise AlwaysLightError, "The sun is always up at this location on #{date}"
    elsif i > 1.0
      raise AlwaysDarkError,  "The sun is always down at this location on #{date}"
    end
    
    acos( i )
  end
  
  # Julian date of solar noon on cycle n
  # TODO: Iteratively recalculate m using j_transit until it stops changing
  def j_transit(_m=m)
    j_star + (0.0053 * sin(_m)) - (0.0069 * sin(2*sun_l))
  end
  
  def recalculate_m
    current_m = m(j_transit)
    last_m = nil
    until close_enough(current_m, last_m)
      last_m = current_m
      current_m = m(j_transit(last_m))
    end
    @m = current_m
  end
  
  # Approximate Julian date of solar noon on cycle n
  def j_star
    2451545 + 0.0009 + (lng_w/360) + n
  end
  
  # Julian date of sunrise on cycle n
  def j_rise
    j_transit - (j_set - j_transit)
  end

  # Julian date of sunset on cycle n
  def j_set
    @j_star = 2451545 + 0.0009 + ((h + lng_w) / 360) + n
    
    @j_star + (0.0053 * sin(@m)) - (0.0069 * sin(2*sun_l))
  end
  
  
  def jd2time (jd)
    dt = DateTime.jd(jd)
    twelve_hour_offset_in_seconds = 12*60*60
    Time.utc(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec) + twelve_hour_offset_in_seconds
  end 

  # There are some edge cases where comparing values was never returning true.
  # This gets around that by ensuring they are "close enough"
  def close_enough(actual, expected)
    return false if expected.nil?
    (actual - expected).abs <= MEAN_SOLAR_ANOMALY_DELTA
  end
end
