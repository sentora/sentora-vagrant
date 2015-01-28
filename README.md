## Sentora Vagrant Development Envs

```
$ vagrant up
```

I'm working on a way to make these envs a little easier for us to configure.
I want a way to lauch an OS depending on user specified params.

Also load folders for sentora /modules , themes etc

Working project - feel free to contact me with any suggestion 

- Branches with different boxes | folder in Setup/boxes ?
- Core/ to hold sentora-core form github
- Development/ holds themes , apps, modules etc currently being developed

- maybe have DevConfig.yaml hold SetoraCorePath: ~/path/to/sentora ?

- ~~ TODO - folders from users sentora git to mount to correct places ~~
- TODO - Folders mounted then run provision to install software & change values , i.e password sub-domain etc
