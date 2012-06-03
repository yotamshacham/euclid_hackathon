import urllib, urllib2;
from threading import Timer

def onTimer():
    print "onTimer, let's poll:"
    URL_PATH = "http://localhost:3000/euclid_poller"
    print 'get(', URL_PATH + ')'
    result = urllib2.urlopen(URL_PATH).read()
    print 'result should be empty=[', result, ']'
    t = Timer(5.0, onTimer)
    t.start();
    
if __name__ == "__main__":
    print 'euclid_polling_driver'
    t = Timer(5.0, onTimer)
    t.start()
