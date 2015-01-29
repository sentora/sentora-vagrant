## Sentora Vagrant Development Envs


#### DevConfig.yaml option
```yaml
privateIp: {false | private ip addr}
publicIp: {false | public ip addr}
cpus: { false | int - default = 1 }
memory: { false | init - default = 1024 }

TODO
```


- TODO , Need provisioner | installer to do what they need to do. Provisioner's run after mounting /sentora-core > /etc/sentora/panel & /sentora-installers/preconf > /etc/sentora/configs & DEV themes /  modules / apps

- If the ones who made the initial installer | beta installer could make a provision for ubuntu-x32 just so we can see how it would work out.

- note that this approach shoudl make it easier for adding future & past OS's / boxes
