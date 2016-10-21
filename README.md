Usage: 

```
virtualenv -p /path/to/python2.7 env
. env/bin/activate
pip install ansible-container
ansible-container build
ansible-container run -d
```

You might also need to run 
```
eval $(docker-machine env)
```
or however else you set your docker env vars.