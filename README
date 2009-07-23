SunTime
=======

Calculate the time of sunrise and sunset for location on a specific date.

Usage
-----

Create a new SunTime instance with a Date and latitude and longitude in decimal format as arguments. Then you can call the `sunrise` and `sunset` methods on that instance.

    require 'sun_time'
    
    date = Date.new(2009, 7, 23)
    latitude = 57.7119                  # N 57° 42′ 42″
    longitude = 11.9683                 # E 11° 58′ 5″
    
    sun_time = SunTime.new(date, latitude, longitude)
    
    sun_time.sunrise
    # => Thu Jul 23 02:50:32 UTC 2009
    
    sun_time.sunset
    # => Thu Jul 23 19:48:56 UTC 2009
    
Note that the times returned are always in UTC, so you have to convert them to your local time yourself if you want that.

If you try to calculate sunrise or sunset for a location where the sun doesn't rise or set on the chosen date, nil is returned:

    winter_in_sweden = SunTime.new(Date.new(2009,12,22), 67.8529, 20.2426)

    winter_in_sweden.sunrise
    # => nil

    winter_in_sweden.sunset
    # => nil

    summer_in_sweden = SunTime.new(Date.new(2009,6,22), 67.8529, 20.2426)

    summer_in_sweden.sunrise
    # => nil

    summer_in_sweden.sunset
    # => nil


Date Extension
--------------

Optionally, you can use SunTime as an extension to the Date class. Here's how you do that:

    require 'sun_time'
    require 'sun_time/date_ext

    date = Date.new(2009, 7, 23)

    date.sunrise(57.7119, 11.9683)
    # => Thu Jul 23 02:50:32 UTC 2009

    date.sunset(57.7119, 11.9683)
    # => Thu Jul 23 19:48:56 UTC 2009
    
License
-------

The MIT License

Copyright (c) 2009 Edithouse eLabs AB

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.