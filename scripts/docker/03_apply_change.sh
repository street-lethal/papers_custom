#!/bin/bash

cd /app/work/papers-50.2
quilt refresh
quilt pop -a
quilt push -a
