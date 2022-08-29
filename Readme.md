# Serverless meilisearch

⚠️ this is WIP, currently doesn't work  ⚠️ 

Goal of this project is to create a serverless meilisearch service on GCP Cloud Run and Cloud Storage using the [gcsfuse](https://github.com/GoogleCloudPlatform/gcsfuse) project.

## Usage 
running the command below creates cloud run instance, new bucket on your specified project
```
./deploy.sh --project [YOUR GCLOUD PROJECT ID]
```
