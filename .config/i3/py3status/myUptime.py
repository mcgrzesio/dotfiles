# -*- coding: utf-8 -*-
#
from datetime import timedelta

class Py3status:
    # configuration parameters
    file = "/proc/uptime"
    cache_timeout = 59.50

    def uptime(self):
        with open(self.file, "r") as f:
            uptime_seconds = float(f.readline().split(".")[0])
            uptime_string = str(timedelta(seconds = uptime_seconds))

        if uptime_seconds > 29700:
            color = self.py3.COLOR_HOME
        else:
            color = self.py3.COLOR_WORK

        response = {
            'cached_until': self.py3.time_in(self.cache_timeout),
            'full_text': uptime_string,
            'color' : color
        }
        return response
