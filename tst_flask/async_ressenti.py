#! /usr/bin/python
# -*- coding:utf-8 -*-

#Deuxième version toute simple du web service ressenti en mode asynchrone
zapli="\n\n async_ressenti.py   zf190416.0929 \n"
zusage="Usage: http://siipc6.epfl.ch:5050/url/http/z.zufferey.com\n\n"

#source: http://sdz.tdct.org/sdz/creez-vos-applications-web-avec-flask.html#Premierspas
#source: https://stackoverflow.com/questions/30554702/cant-connect-to-flask-web-service-connection-refused
#source: https://stackoverflow.com/questions/89228/calling-an-external-command-in-python
#source: https://openclassrooms.com/fr/courses/235344-apprenez-a-programmer-en-python/2235545-faites-de-la-programmation-parallele-avec-threading


import datetime
import time
import os
import subprocess
import threading
#from threading import Thread
from flask import Flask, redirect, url_for, request

app = Flask(__name__)
zstack = []
ztime_table = dict()


class zbench_time(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)

    def run(self):
        while str(threading.enumerate()[0]).find("started") > 0 :
            while len(zstack) > 0 :
                print("zbench_time zstack: " + str(zstack))
                zurl = zstack[0]
                print("je mesure: " + zurl)
                time.sleep(3)               #je vais mesurer l'url :-)
                ztime_table[zurl][0] = datetime.datetime.now()
                print("url retiree: " + zstack.pop(0))        #je retire l'url du fifo
            time.sleep(2)
            print("je boucle :-)")
            print("len of stack: " + str(len(zstack)))
            print("thread.enumerate: " + str(str(threading.enumerate()[0]).find("started")))



def zget_time(zget_url):
    if ztime_table.get(zget_url, True):
        ztime_table[zget_url]={}
        ztime_table[zget_url][0] = "0"
    return ztime_table[zget_url][0]




@app.route('/toto')
def toto():
    zurl = request.args.get('url')
    print("url: " + zurl)
    zstack.append(zurl)
    print("route toto zstack: " + str(zstack))
    print("route toto ztime_table: " + str(ztime_table))

    return zapli + "<br><br>c'est ok !  " + zget_time(zurl)









@app.route('/')
def index():
    zurl = request.args.get('url')
    print("url: " + zurl)
    zimg = zurl.replace('http://', '')  ;  zimg = zimg.replace('https://', '')  ;  zimg = zimg.replace('/', '_')
    print("img: " + zimg)

    start = time.time()
#    cmd = "timeout 31 firefox -headless -screenshot toto.png " + proto + "://" + url + " 2>/dev/null"
    cmd = "docker exec -it docker-ressenti /bin/bash /root/work/screenshot.sh  " + zurl + " " + zimg
    os.system(cmd)
    end = time.time()
    result = str(end-start)
    return zapli + "<br><br>ça a tourné en " + result + " secondes" 






if __name__ == '__main__':
    print (zapli)
    print(zusage)

    thread_1 = zbench_time()
    thread_1.start()
    app.run(host='0.0.0.0',port=5000, debug=True, use_reloader=False)



