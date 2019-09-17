# PMACCT docker container

Docker image for PMACCT ( https://github.com/pmacct/pmacct )

> pmacct is a small set of multi-purpose passive network monitoring tools. It can account, classify, aggregate, replicate and export forwarding-plane data, ie. IPv4 and IPv6 traffic; collect and correlate control-plane data via BGP and BMP; collect and correlate RPKI data; collect infrastructure data via Streaming Telemetry. Each component works both as a standalone daemon and as a thread of execution for correlation purposes (ie. enrich NetFlow with BGP data).

Additional ./configure switches used in this build:
* --enable-plabel 
* --enable-postgres
* --enable-rabbitmq
* --enable-jansson
* --enable-geoipv2

### Install

```sh
docker pull vargat/pmacct:latest
```

### Running

Run with: 
```sh
docker run --name pmacct -v /path/to/my/config:/config/nfacctd.conf vargat/pmacct:latest
```

alternatively you can mount the config directory, where you store other pmacct related files, like labels and mappings:

```sh
docker run --name pmacct -v /path/to/myconfigdirector:/config vargat/pmacct:latest
```

