#!/bin/bash
rake db:setup && cd /var/lib/go-agent/pipelines/demo && rails server -b 0.0.0.0 > /dev/null 2>&1 &
