#!/bin/sh

nodejs geocode-rdf.js | grep -v ^\\[.*$ | grep -v 'Node is' | grep -v 'Refs'
