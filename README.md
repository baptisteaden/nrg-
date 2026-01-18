# NRG- Energy dashboard

## Prerequisites

Have Docker installed

## How to use

### Init

Run these commands just once

```sh
# 1. Create a docker network for Superset to be able to access the database
docker network create superset-network
```

### Usage

Run these commands whenever you want to use the project

```sh
# 1. Start database
docker compose up -d

# 2. Start Superset (takes ~1min)
cd superset
docker compose -f docker-compose-image-tag.yml down && docker compose -f docker-compose-image-tag.yml up -d
cd ..
```

From there, you should be able to access Superset at http://localhost:8088

To parse and store a bill in the database: `docker compose --profile batch run --rm pdf_parser --type=edf ./bills/file.pdf`

> This is just running this command in a container (so you don't have to install python and dependencies locally): `python parse.py --type=edf ./bills/file.pdf`