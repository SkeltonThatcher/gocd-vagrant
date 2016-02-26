#!/bin/bash
rake db:setup && rake assets:precompile && rails server -d -b 0.0.0.0 > /dev/null 2>&1
