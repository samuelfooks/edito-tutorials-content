#!bin/bash

pip install copernicus-marine-client
pip install cdsapi
pip install h5netcdf

echo "url: https://cds.climate.copernicus.eu/api/v2" > ~/.cdsapirc
echo "key: $CDS_UID:$CDS_APIKEY" >> ~/.cdsapirc

git clone --depth 1 --branch master --no-checkout https://${GIT_USER_NAME}:${GIT_PERSONAL_ACCESS_TOKEN}@gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/
cd ~/work/edito-tutorials-content/
git sparse-checkout set sources/DataRetrieval
git checkout master
cd sources/DataRetrieval
