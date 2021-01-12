# LibreSpeed - Custom Docker Version

This is modified by @intelpanic the Docker version of LibreSpeed based on nginx-unit image.

## Installation
1. Prepare docker swarm host and clone this repo content to it.
2. Fill `.env` and `traefik.env.sh` files (from `deploy` folder) using appropriate templates with your data.
3. Run `up.sh` script and wait couple minutes.
4. Enjoy!

## Modified/Added files
* `docker/servers.json`
* `docker/config.json`
* `docker/entrypoint.sh`
* `deploy/*`
* `Dockerfile`
* `README.md`
* `app.compose.yml`
* `efk.compose.yml`
* `down.sh`
* `up.sh`

## License
Copyright (C) 2016-2020 Federico Dossena

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/lgpl>.
