#!/usr/bin/env python

import sys

from flask import Flask, Response

app = Flask(__name__)

@app.route('/')
def test():
  """Dummy flask test"""
  return Response('{"test": true}',
                  mimetype="application/json",
                  status=200)

if __name__=='__main__':
  # Making flask listen to all interfaces.
  app.run(host='0.0.0.0', port=sys.argv[1])
