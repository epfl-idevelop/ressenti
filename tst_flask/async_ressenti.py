#! /usr/bin/python
# -*- coding:utf-8 -*-

#Deuxième version toute simple du web service ressenti en mode asynchrone
zapli="\n\nsync_ressenti.py   zf190415.1603 \n"
zusage="Usage: http://siipc6.epfl.ch:5050/url/http/z.zufferey.com\n\n"

#source: http://sdz.tdct.org/sdz/creez-vos-applications-web-avec-flask.html#Premierspas
#source: https://stackoverflow.com/questions/30554702/cant-connect-to-flask-web-service-connection-refused
#source: https://stackoverflow.com/questions/89228/calling-an-external-command-in-python


import time
import os
import subprocess

from flask import Flask, redirect, url_for, request
app = Flask(__name__)





@app.route('/toto')
def toto():
    zurl = request.args.get('url')
    print("url: " + zurl)

    return "c'est ok !"



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
    app.run(host='0.0.0.0',port=5000, debug=True)
