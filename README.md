# gocd-vagrant

## Spin Up VM

To spin up a VM with GoCD server (and 1 agent) installed run:

`vagrant up`

## Pipeline View

When finished you should see a basic pipeline:

[Build_Unit_Tests] -> [Acceptance_Tests] -> [Security_Tests] -> [Deploy_To_Production]

[http://localhost:8153/go](http://localhost:8153/go)

### Troubleshoot

If not available, the Go Server might not be running, in which case do the following:

`vagrant ssh`
`sudo /etc/init.d/go-server start`

Note that the "Started Go Server" is misleading, the server is not ready to use yet.
You can follow progress in the log:

`tail -f /var/log/go-server/go-server.log`

When you see a log message containing "Initializing database: jdbc:" then it's **really** ready.

## Demo Vulnerable App 

After the first pipeline runs (normally starts automatically) you should see the "Railsgoat" vulnerable app here:

[http://localhost:8080](http://localhost:8080)
