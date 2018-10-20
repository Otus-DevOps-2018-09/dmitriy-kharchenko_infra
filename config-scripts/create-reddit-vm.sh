#!/bin/bash

gcloud beta compute --project=infra-219305 instances create reddit-app \
--zone=europe-west4-b \
--machine-type=f1-micro \
--subnet=default \
--network-tier=PREMIUM \
--maintenance-policy=MIGRATE \
--service-account=117883598655-compute@developer.gserviceaccount.com  \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=reddit-full-1540039177 \
--image-project=infra-219305 \
--boot-disk-size=10GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=reddit-app
