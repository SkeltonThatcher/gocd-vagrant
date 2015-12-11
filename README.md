# gocd-vagrant

To spin up a VM with GoCD server (and 1 agent) installed run:

`vagrant up`


When finished you should see a basic pipeline:

[Build_Unit_Tests] -> [Acceptance_Tests] -> [Security_Tests] -> [Deploy_To_Production]

by following this URL:

[http://localhost:8153/go](http://localhost:8153/go)

