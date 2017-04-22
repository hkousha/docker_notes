#!/usr/bin/env python

from flask import Flask, Response

app = Flask(__name__)

@app.route('/')
def test():
  """Dummy flask test"""
  return Response('{"test": true}',
                  mimetype="application/json",
                  status=200)

if __name__=='__main__':
  app.run(port=8000)
