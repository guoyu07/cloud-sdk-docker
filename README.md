
# Google Cloud SDK Docker


This is Docker image for the [Google Cloud SDK](https://cloud.google.com/sdk/).

Image includes default command line tools:
*  gcloud:  Default set of gcloud commands
*  gsutil:  Cloud Storage Command Line Tool
*  bq: BigQuery Command Line Tool

## Supported tags and respective Dockerfile links

- [155.0.0, latest] (Dockerfile)

## Usage

To use this image, pull from [Docker Hub](https://hub.docker.com/r/google/cloud-sdk/), run the following command:


```
docker pull google/cloud-sdk:latest
```

verify the install
```bash
docker run -ti  google/cloud-sdk:latest gcloud version
Google Cloud SDK 155.0.0
bq 2.0.24
core 2017.05.10
gcloud 
gsutil 4.26
```

or specify a version number:

```bash
docker run -ti google/cloud-sdk:155.0.0 gcloud version
```

Then authenticate by running:

```
docker run -ti --name gcloud-config google/cloud-sdk gcloud auth login
```

Once authentication succeeds, credentials are preserved in the volume of _gcloud-config_ container. 
To list compute instances using these credentials, use the configured volume:
```
docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud compute instances list --project your_project
NAME        ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP      STATUS
instance-1  us-central1-a  n1-standard-1               10.240.0.2   8.34.219.29      RUNNING
```

> :warning: **Warning**:  the volume gcloud-config now has your credentials/JSON key file embedded in it; carefully control access to it.

### Installing additional components

If you need to run additional gcloud components, you need to extend the base image:

For example, for appengine-python:
```dockerfile
FROM google/cloud-sdk
RUN gcloud components install app-engine-python
```

or for app-engine-java
```dockerfile
FROM google/cloud-sdk
RUN apk --update add openjdk7-jre
RUN gcloud components install app-engine-java
```

### Google App Engine base

The original image in this repository was based off of 

> FROM gcr.io/google_appengine/base

The full Dockerfile for that can be found [here](google_appengine_base/Dockerfile) for archival.