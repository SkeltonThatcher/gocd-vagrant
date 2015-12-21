# gocd-vagrant

To spin up a VM with GoCD server (and 1 agent) installed run:

`vagrant up`


When finished you should see a basic pipeline:

[Build_Unit_Tests] -> [Acceptance_Tests] -> [Security_Tests] -> [Deploy_To_Production]

[http://localhost:8153/go](http://localhost:8153/go)


After the first pipeline runs you should see the "Railsgoat" vulnerable app here:

[http://localhost:8080](http://localhost:8080)
