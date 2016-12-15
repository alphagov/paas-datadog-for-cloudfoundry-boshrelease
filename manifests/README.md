bosh-lite sample manifest
-------------------------

Manifest for this release ready to be deployed on bosh-lite, for development and testing.

How to generate it?
--------------------

This manifest is split for readability, and spruce is required to render it. Run:

```
# Generate it
export BOSH_UUID=$(bosh status --uuid) # Optional, override the bosh uuid
export DATADOG_API_KEY=$(paas-pass datadog/dev/datadog_api_key) # Optional, integrate with datadog

export DEPLOY_ENV=... # Recommended if integrating with datadog.
./manifests/build-manifest.sh > /tmp/manifest.yml

```

How to use it?
--------------

You must upload an stemcell in your bosh-lite, and create and upload this release:

```
# Upload the stemcell
bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

# Build this release
bosh create release --with-tarball --name datadog-for-cloudfoundry

# Upload it
bosh upload release $(ls -tr dev_releases/datadog-for-cloudfoundry/datadog-for-cloudfoundry-*.tgz | tail -1)

# Use it
bosh deployment /tmp/manifest.yml
bosh deploy
```

Instead of building/uploading the release, you can use the release generated in the build concourse by editing the manifest.


What is included?
-----------------

The manifest includes a group of jobs configured to start the services
that this release wants to monitor. It includes all the boilerplate
required to start the CF services.

Most of the configuration of the boilerplate is the minimum to make the
services deploy, start and run, so that they can be monitored.
The values are not right or relevant, and had been extracted from other
examples. The services are not fully functional without a proper installation.
