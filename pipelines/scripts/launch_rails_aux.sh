#!/bin/bash
rake db:setup && cd /var/lib/go-agent/pipelines/demo && rails server > /dev/null 2>&1 &
