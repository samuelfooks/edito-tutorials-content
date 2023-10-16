#!bin/bash

pip install copernicus-marine-client
pip install h5netcdf

git clone --depth 1 --branch master --no-checkout https://${GIT_USER_NAME}:${GIT_PERSONAL_ACCESS_TOKEN}@gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/
cd ~/work/edito-tutorials-content/
git sparse-checkout set sources/OceanBench
git checkout master
cd sources/OceanBench
