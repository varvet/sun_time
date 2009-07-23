require 'date'
require 'sun_time/degree_trig'

class SunTime
  
  class AlwaysDarkError < ::StandardError; end
  class AlwaysLightError < ::StandardError; end
  
  attr_reader :date, :lat, :lng
  
  def initialize (date, lat, lng)
    @date = date
    @lat = lat
    @lng = lng
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
    m = @m || self.m #198.23212102042
    c = c(m) #-0.58743698541815
    (m + 102.9372 + c + 180) % 360
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
    until current_m == last_m
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
  
private
  
  # Julian date of sunset on cycle n
  def j_set
    @j_star = 2451545 + 0.0009 + ((h + lng_w) / 360) + n
    
    @j_star + (0.0053 * sin(@m)) - (0.0069 * sin(2*sun_l))
  end
  
  include DegreeTrig
  
  def jd2time (jd)
    dt = DateTime.jd(jd, 12)
    Time.utc(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
  end 
end