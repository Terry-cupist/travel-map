FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       osm2pgsql \
       postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data
COPY docker/load-osm.sh /load-osm.sh
RUN chmod +x /load-osm.sh

ENTRYPOINT ["/load-osm.sh"]
