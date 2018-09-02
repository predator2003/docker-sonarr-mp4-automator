# mp4-automator_hvec_watcher
A docker container based on linuxserver/sonarr with mp4 automation baked in

## Usage
````

docker pull streamboxx/mp4_automator_hvec

docker run \
    --name mp4-automator_hvec_watcher \
    --restart unless-stopped \
    --device /dev/dri:/dev/dri
    -v /opt/mp4_automator/:/config \
    -v <path to data>/mp4_automator:/config_mp4_automator \
    streamboxx/mp4-automator_hvec
    


    
    
    
    
        -e PUID=1001 -e PGID=1001 \
        -e TZ="America/Chicago"  \
    

````

## mkdir
Makes a symlink from sickbeard_mp4_automator to a config directory that is a volume for the container. If the host has a config file (autoProcess.ini) in the mounted volume, then sickbeard_mp4_automator will be able to use that. This is useful if you are running multiple containers but want to share the mp4 automation configuration between them. It also has the benefit of being able to modify the config from the host OS.
