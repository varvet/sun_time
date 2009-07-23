require "test/unit"

require File.expand_path(File.join(File.dirname(__FILE__), "../lib/sun_time/degree_trig"))

class TestDegreeTrig < Test::Unit::TestCase
  include SunTime::DegreeTrig
  
  def test_sin
    assert_in_delta(0.017452406437284, sin(1), 2 ** -20)
  end
  
  def test_cos
    assert_in_delta(0.999847695156391, cos(1), 2 ** -20)
  end
  
  def test_tan
    assert_in_delta(0.017455064928218, tan(1), 2 ** -20)
  end
  
  def test_asin
    assert_in_delta(r2d(1.57079633), asin(1), 2 ** -20)
  end
  
  def test_acos
    assert_in_delta(r2d(0), acos(1), 2 ** -20)
    assert_in_delta(r2d(1.04719755), acos(0.5), 2 ** -20)
  end
  
  def test_atan
    assert_in_delta(r2d(0.785398163), atan(1), 2 ** -20)
  end
  
  def test_degrees_to_radians
    assert_in_delta(0.0174532925, d2r(1), 2 ** -20)
  end

  def test_radians_to_degrees
    assert_in_delta(57.2957795, r2d(1), 2 ** -20)
  end
end
