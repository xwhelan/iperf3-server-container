# iperf3-server-container

Run iperf3 server in container

## Rationale

I want to test network throughput from my home compute server to my Synology
NAS. So I will put iperf3 in a container, make sure it runs as server,
and host it on GitHub Packages.

## Gotchas

- Synology Docker service doesn't actually support the token based
  authentication scheme of ghcr.io
- I tried hosting a container registry locally on the compute node.
  - On the one hand, Docker makes the registry server available as a
    container, so it was easy to fire up with `docker-compose`
  - On the other hand, I would have to provision it with a SSL certificate
    to get it working over HTTPS, or with http basic auth
  - On the gripping hand, `docker pull` is finicky, as is the Synology
    Docker service, so there is no guarantee that all the effort would actually
    let me pull the container locally from Synology anyway.
- I reactivated my old, dormant Docker Hub account and pushed the image from
  ghcr to it
  - First was a lot of problems with versions of Docker hitting old endpoints,
    so ended up having to do a lot of `docker login` by trial and error
  - Next, had to re-tag images to get them pushed to Hub
  - Finally, learned again that Docker on M1 builds `arm64` images, and my
    Synology is Intel Celeron `amd64`, so I had to go back and get the
    ghcr.io image anyway

Finally, I was able to instantiate a container on Synology, and connect with
iperf3... and saw that my transfer speed was about 840 Mbits/sec, which I kind of
expected for a Gigabit switched network.

And that's all the Docker service on Synology is good for -- it is rudimentary,
to the point that my own puttering with `systemd` and `docker-compose` is
more supportable.
