#! /usr/bin/python
# -*- coding:utf-8 -*-

#Juste un petit HelloWorld pour tester Flask ;-)
#zf190412.1657

#source: http://sdz.tdct.org/sdz/creez-vos-applications-web-avec-flask.html#Premierspas
#source: https://stackoverflow.com/questions/30554702/cant-connect-to-flask-web-service-connection-refused


from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
   return "Hello zuzu !"

@app.route('/hello/<phrase>')
def hello(phrase):
   return phrase


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000, debug=True)


