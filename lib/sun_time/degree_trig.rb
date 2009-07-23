class SunTime
  module DegreeTrig
    def r2d (v)
      180/Math::PI * v 
    end
  
    def d2r (v)
      Math::PI/180 * v
    end
  
    def sin (d)
      Math.sin(d2r(d))
    end
  
    def asin (d)
     r2d Math.asin(d)
    end
  
    def cos (d)
      Math.cos(d2r(d))
    end
  
    def acos (d)
      r2d Math.acos(d)
    end
  
    def tan (d)
      Math.tan(d2r(d))
    end
  
    def atan (d)
      r2d Math.atan(d)
    end
  end
end