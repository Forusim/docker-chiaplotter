![](https://www.chia.net/img/chia_logo.svg)

# Chia plotter docker image
A simple and scalable docker image for creating Chia plots via https://github.com/swar/Swar-Chia-Plot-Manager.

## Configuration
Required configuration:
* Bind mounting a host temp dir in the container to `/temp` (e.g. `-v /path/to/sdd/storage/:/temp`)
* Bind mounting a host plot dir in the container to `/plots`  (e.g. `-v /path/to/hdd/storage/:/plots`)
* Bind mounting a host config dir in the container to `/config`  (e.g. `-v /path/to/storage/:/config`)

Optional configuration:
* Setting the autostart of plotting manager via environment (e.g. `-e AUTOSTART=yes`)

On first start:
* Open `/config/config.yaml` for editing
* Set `chia_location` to `/chia-blockchain/venv/bin/chia`
* Set `log:folder_path` to `/config/logs`
* In the `jobs` section set following values for each job:
  * Set `farmer_public_key` according to existing full node (`chia keys show`)
  * Set `pool_public_key` according to existing full node (`chia keys show`)
  * Set `temporary_directory` to `/temp`
  * Set `destination_directory` to `/plots`
* Adjust the rest according to your needs

## Operation
Open docker shell:
* docker exec -it `containerid` sh

Control plotting:
* python manager.py start (Start plotting jobs according to `config.yaml`)
* python manager.py restart (Reload after `config.yaml` change - timers will be reset)
* python manager.py stop (Stop new plotting jobs - running jobs will be finished)

Observe plotting:
* python manager.py view
