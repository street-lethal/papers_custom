#!/bin/bash

cd /app/work/papers-50.2
dch --local +rtl 'Add Ctrl+Alt+R shortcut for Right to Left Document'
dpkg-buildpackage -us -uc
