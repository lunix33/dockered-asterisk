# Description

This project containerize the Asterisk PBX into Docker.

It uses the version 19.0.0 of Asterisk coming from the official project
repository, and is installed on top of Ubuntu (20.04) with the english
sound pack.

This project doesn't implement any specific security features since it's out of
the score of the project at the moment. Any specific needs can be addressed by
extending the current image.

See the list of [missing modules](#missing-modules) to see which asterisk
modules aren't present in the current image.

# How to use

The image can be build using the `make` (or `make build`) command. This will
build the docker image and may take about 15 minutes to do so.

To run the image `make run` can be used. This will start a container using
the image built with `make`.

By default, the container will use a `host`
network configuration.\
Will mount the `AST_LOCAL_CONFIG` (default: `{project_root}/config`) to
`/etc/asterisk` and `AST_LOCAL_SPOOL` (default: `{project_root}/spool`) to
`/run/spool/asterisk` as volumes.\
The container is also set to restart automatically unless explicitly
stopped using `docker stop`.

If needs be, other volumes can me added to the makefile command to fit your
needs.

```sh
# Default run command
docker run -d \
		--restart=unless-stopped \
		--network="host" \
		--volume="${CUR_DIR}config:/etc/asterisk" \
		--volume="${CUR_DIR}spool:/run/spool/asterisk" \
		${IMAGE_NAME}
```

# Application samples

Sample configuration for Asterisk can be downloaded from the official asterisk
repository.

https://github.com/asterisk/asterisk/tree/19.0.0/configs

# Missing modules

The following modules are currently missing from the image:

- Add-ons
  - chan_mobile
- Applications
  - app_flash
  - app_saycounted
  - app_statsd
  - app_macro
  - app_meetme
  - app_osplookup
- Bridging modules
  - binaural_rendering_in_bridge_softmix
- Call detail record
  - cdr_beanstalkd
  - cdr_radius
- Cell event logging
  - cel_beanstalkd
  - cel_radius
- Channel drivers
  - chan_dahdi
  - chan_alsa
  - chan_mgcp
  - chan_sip
  - chan_skinny
- Codec translators
  - codec_dahdi
  - codec_opus
  - codec_silk
  - codec_siren7
  - codec_siren14
  - codec_g729a
- PBX modules
  - pbx_dundi
- Resource modules
  - res_ari_mailboxes
  - res_mwi_external
  - res_mwi_external_ami
  - res_stasis_mailbox
  - res_timing_dahdi
  - res_chan_stats
  - res_corosync
  - res_endpoint_stats
  - res_remb_modifier
  - res_snmp
  - res_timing_kqueue
  - res_monitor
  - res_pktccops
  - res_digium_phone
