#! /usr/bin/python
# -*- coding:utf-8 -*-

#Juste un petit test pour voir comment exécuter une command en shell et afficher le résultat avec Flask ;-)
#zf190412.1849

#use: http://siipc6.epfl.ch:5050/url/http/z.zufferey.com

#source: http://sdz.tdct.org/sdz/creez-vos-applications-web-avec-flask.html#Premierspas
#source: https://stackoverflow.com/questions/30554702/cant-connect-to-flask-web-service-connection-refused
#source: https://stackoverflow.com/questions/89228/calling-an-external-command-in-python

import time
import os
import subprocess

from flask import Flask
app = Flask(__name__)

@app.route('/url/<proto>/<url>')
def index(proto,url):
    start = time.time()
    cmd = "timeout 31 firefox -headless -screenshot toto.png " + proto + "://" + url + " 2>/dev/null"
    os.system(cmd)
    end = time.time()
    result = str(end-start)
    return "ça a tourné en " + result + " secondes" 

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000, debug=True)


