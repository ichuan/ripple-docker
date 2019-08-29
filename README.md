# ripple-docker
Docker builds for ripple, with ws/wss port 6005 exposed


## Build

```
docker build -t ripple .
```

## Run

```
docker run --rm -itd --name ixrp -p 6005:6005 ripple
```

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/ripple/>:

```
docker run --rm -itd --name ixrp -p 6005:6005 mixhq/ripple
```
