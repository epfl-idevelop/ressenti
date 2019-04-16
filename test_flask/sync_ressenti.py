#!/usr/bin/env python
# -*- coding:utf-8 -*-

#Première version toute simple du web service ressenti en mode synchrone
#use: http://siipc6.epfl.ch:5050/url/http/z.zufferey.com

print ("\n\nsync_ressenti.py   zf190415.1108 ")
print("\nUsage: http://siipc6.epfl.ch:5050/url/http/z.zufferey.com\n\n")

#source: http://sdz.tdct.org/sdz/creez-vos-applications-web-avec-flask.html#Premierspas
#source: https://stackoverflow.com/questions/30554702/cant-connect-to-flask-web-service-connection-refused
#source: https://stackoverflow.com/questions/89228/calling-an-external-command-in-python


import time
import os
import random
import subprocess

from flask import Flask, request, Response
app = Flask(__name__)


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
    # start = time.time()
    # cmd = "timeout 31 firefox -headless -screenshot toto.png " + proto + "://" + url + " 2>/dev/null"
    # os.system(cmd)
    # end = time.time()
    # result = str(end-start)
    result = random.random()

    metrics = Metrics()
    metrics.add('probe_duration_seconds', 'gauge', result + 0.04)

    metrics.add('probe_ressenti_duration_seconds', 'gauge', result,
                labels={'phase': 'connect'})

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
    app.run(host='0.0.0.0',port=9116, debug=True)
