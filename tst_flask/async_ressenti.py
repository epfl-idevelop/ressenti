#! /usr/bin/python
# -*- coding:utf-8 -*-

#Deuxième version toute simple du web service ressenti en mode asynchrone
zapli="\n\n async_ressenti.py   zf190418.1504 \n"
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
import random
from flask import Flask, redirect, url_for, request, Response

app = Flask(__name__)
zstack = []
ztime_table = dict()


class zbench_time(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)

    def run(self):
        while str(threading.enumerate()[0]).find("started") > 0 :
            while len(zstack) > 0 :
                print("zbench_time, zstack: " + str(zstack))
                zurl = zstack[0]
                print("zbench_time, je mesure: " + zurl)
#                time.sleep(5)               #je vais mesurer l'url :-)
#                ztime_table[zurl] = (5, datetime.datetime.now())


                zimg = zurl.replace('http://', '')  ;  zimg = zimg.replace('https://', '')  ;  zimg = zimg.replace('/', '_')
                print("zbench_time, img: " + zimg)
                zstart = time.time()
                cmd = "docker exec -it docker-ressenti /bin/bash /root/work/screenshot.sh  " + zurl + " " + zimg
                print("zbench_time, cmd: " + cmd)
                os.system(cmd)
                zend = time.time()
                zresult = str(zend-zstart)
                ztime_table[zurl] = (zresult, datetime.datetime.now())



                print("zbench_time, ztime_table: " + str(ztime_table))
                print("zbench_time, url retiree: " + zstack.pop(0))        #je retire l'url du fifo
                print("zbench_time, len of stack: " + str(len(zstack)))
            time.sleep(2)
            print("zbench_time, je boucle :-)")
#            print("zbench_time, thread.enumerate: " + str(str(threading.enumerate()[0]).find("started")))



def zcheck_time(zcheck_url):
    print("zcheck_time, zcheck_url: " + str(zcheck_url))
    if ztime_table.get(zcheck_url, False):
        print("zcheck_time, elle existe !")
    else:
        ztime_table[zcheck_url]={}
        ztime_table[zcheck_url] = ("0", datetime.datetime.now())
        print("zcheck_time, elle n'existe pas !")
    return 


def zcheck_stack(zurl):
    print("\n\nzcheck_stack, url: " + zurl)
    print("zcheck_stack, zstack: " + str(zstack))
    if zurl in zstack:
        print("zcheck_stack, existe")
    else:
        print("zcheck_stack, n'existe pas")
        zstack.append(zurl)
    print("zcheck_stack, zstack: " + str(zstack))
    print("zcheck_stack, ztime_table: " + str(ztime_table))



@app.route('/toto')
def toto():
    zurl = request.args.get('url')
    zcheck_stack(zurl)
    zcheck_time(zurl)
    zresponse = zapli + "<br><br>" + str(zurl) + "a duré " + str(ztime_table[zurl][0]) + " secondes à " + str(ztime_table[zurl][1])
    return zresponse


@app.route('/tutu')
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





@app.route('/ressentiprobe')
def probe():
    module = request.args['module']
    target = request.args['target']
    if module == 'ressenti_firefox':
        return ressenti_firefox(target)
    elif module == 'ressenti_chrome':
        return ressenti_chrome(target)
    else:
        return 'Break Citroën', 404




def ressenti_firefox(target):
    zurl = target
    zcheck_stack(zurl)
    zcheck_time(zurl)

    result = str(ztime_table[zurl][0])

    metrics = Metrics()
    metrics.add('probe_duration_seconds', 'gauge', result)

#    metrics.add('probe_ressenti_duration_seconds', 'gauge', result,
#                labels={'phase': 'connect'})

    return metrics.as_flask_response()





def ressenti_chrome():
    raise Exception('No chrome for you')


class Metrics:
    """Over-engineered Prometheus metrics container / pretty-printer.
    @see https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md
    """
    def __init__(self):
        self.metrics = []

    def __repr__(self):
        return ''.join(self.metrics)

    def add(self, name, type, value, help=None, labels=None):
        metric_lines = ["# TYPE %s %s" % (name, type)]
        if help:
            metric_lines.insert(0, "# HELP %s %s" % (name, help))
        if labels:
            qualified_name = '%s{%s}' % (
                name,
                ','.join('%s="%s"' % (k, v) for (k, v) in labels.items()))
        else:
            qualified_name = name
        metric_lines.append("%s %s" % (qualified_name, value))

        self.metrics.append(''.join('%s\n' % l for l in metric_lines))

    def as_flask_response(self):
        return Response(self.__repr__(), mimetype='text/plain; version=0.0.4')









if __name__ == '__main__':
    print (zapli)
    print(zusage)

    thread_1 = zbench_time()
    thread_1.start()
    app.run(host='0.0.0.0',port=5000, debug=True, use_reloader=False)



