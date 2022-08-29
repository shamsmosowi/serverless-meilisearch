#!/bin/bash

helpFunction()
{
   echo "Usage: ./deploy.sh --project [YOUR GCLOUD PROJECT ID]"
   exit 0
}

while test $# -gt 0; do
           case "$1" in
                --project)
                    shift
                    project_id=$1
                    shift
                    ;;
                *)
                   echo "$1 is not a recognized flag!"
                   return 1;
                   ;;
          esac
  done  

if [[ -z "$project_id" ]];
then
   helpFunction
fi

name=serverless-meilisearch
bucket=$project_id-meilisearch
region=us-central1
gcloud config set project $project_id
gcloud config set run/region $region

if ! gsutil ls -p $project_id gs://$bucket &> /dev/null;
    then
        echo creating gs://$bucket ... ;
        gsutil mb -p $project_id -c regional -l $region gs://$bucket;
        sleep 5;
    else
        echo "Bucket $bucket already exists!"
fi

gcloud builds submit --tag gcr.io/$project_id/$name
gcloud beta run deploy $name --image gcr.io/$project_id/$name --platform managed --memory 4Gi --cpu 2.0  --execution-environment=gen2 --allow-unauthenticated --update-env-vars="BUCKET=$bucket,MEILI_MASTER_KEY=superSecret" --port 7700