# Jupyter demo

Small demo to run a local Jupyter server using docker.

## Dependecies 
- Docker

### Running the container
From the terminal run: 

```console
$ docker run --name jupyter \
      -v $(pwd)/work:/home/jovyan/work \
      -p 8888:8888 \
      quay.io/jupyter/base-notebook
```
This will dowload the base-notebook image if you don't already have it and attach the `work/` directory to the container
> This command needs to be executed from the path from where you are reading this file

Once executed, the container will start running and you will see the output on the terminal. Within the output look for the following section:

```

    To access the server, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/jpserver-7-open.html
    Or copy and paste one of these URLs:
        http://4cbe3e9f5533:8888/lab?token=8c8126f6579bc29543ce6d60c4f886a2642e6162e4c26cba
        http://127.0.0.1:8888/lab?token=8c8126f6579bc29543ce6d60c4f886a2642e6162e4c26cba

```

copy one of the urls on the browser and you are all set to go! 
> some of the values from the above URL will deffer for your execution so copy pasting the values from this file wont work

### Jupyter images

If you want to checkout other images take a look at the Jupyter org in quay.io: https://quay.io/organization/jupyter
