![](https://www.chia.net/img/chia_logo.svg)

# Chia plotter docker image
A simple and scalable docker image for creating Chia plots via https://github.com/madMAx43v3r/chia-plotter

## Configuration
Required configuration:
* Bind mounting a host temp dir in the container to `/temp` (e.g. `-v /path/to/sdd/storage/:/temp`)
* Bind mounting a host plot dir in the container to `/plots`  (e.g. `-v /path/to/hdd/storage/:/plots`)
* Bind mounting a host config dir in the container to `/config`  (e.g. `-v /path/to/storage/:/config`)

Optional configuration:
* Setting the autostart of plotting manager via environment (e.g. `-e AUTOSTART=yes`)
* Setting the time zone of plotting manager via environment (e.g. `-e TZ=Europe/Berlin`)

On first start:
* Open `/config/plotter.cfg` for editing
* Adjust the parameters according to your needs

## Operation
Open docker shell:
* docker exec -it `containerid` sh

Control plotting:
* bash start.sh (Start plotting according to `plotter.cfg`)
* bash stop.sh (Stop plotting gracefully - running job will be finished)

Observe plotting:
* docker logs --follow `containerid`
