#!/bin/bash

dch --local +rtl 'Add Ctrl+Alt+R shortcut for Right to Left Document'
dpkg-buildpackage -us -uc
