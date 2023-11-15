# Host your own web application

To add any service to our platform, you will have to make a pull request to our [Ocean Modelling Helm Charts](https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-modelling-helm-charts) repository.

This tutorial provide the guideline to follow to create your own helm chart that can host a Docker image web application. Do not hesitate to look at other charts to get inspired.

First thing first, you will need to have a Docker image hosted on a public repository. This image should run a container exposing a web service through a port.

In this tutorial, we will take [TerriaMap datalab service](https://datalab.staging.edito.eu/launcher/oceanmodelling/terria-map-viewer) as an example. The [TerriaMap github project is available here](https://github.com/TerriaJS/TerriaMap) if you want to know more about it.

And as you can see, this project satisfy the minimal requirement for hosting a web application on the datalab, which is having a public docker image available. You can find the correspong [Dockerfile here](https://github.com/TerriaJS/TerriaMap/blob/main/deploy/docker/Dockerfile) if you need to inspire you. Here, it is only running a node application on the port **3001**.

## Clone the repository

```sh
git clone https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-modelling-helm-charts.git
```

## Create your own chart folder

You can start by copying the content `web-app-template` folder inside your own folder.

```sh
cp terria-map-viewer terriamap-copy-example
```

## Update the chart configuration

### Edit the `Chart.yaml` file

Change the following fields and leave the others unchanged:

- name (the name of your application, using only alphanumerical characters without spaces. Also known as [kebab-case](https://en.wikipedia.org/wiki/Naming_convention_(programming)) convention)
- description (a brieve description of your application)
- icon (an image that represent the underlying application)
- keywords (a list of useful keywords that can be used to retrieve your application from the datalab search bar)
- version (the version of the chart. Starts with 1.0.0 and update later if you need some changes)
- appVersion (the version of the application running inside your docker container. Here the TerriaMap version)

```yaml
name: terriamap-copy-example
description: Run a TerriaMap viewer server copy example.
icon: https://github.com/TerriaJS/TerriaMap/raw/main/terria-logo.png
keywords:
  - Viewer
version: 1.0.0
appVersion: "8.3.0"
```

### Edit the `templates/NOTES.txt` file

The content will be rendered and displayed in a pop-up window while the service is being launched.

```txt
Your TerriaMap copy example application is being deployed.

It will be available on this [link](http{{ if $.Values.ingress.tls }}s{{ end }}://{{ .Values.ingress.hostname }}).
```

As you may see, you can use Helm values in this template file. Please take a look at the official [Helm documentation](https://helm.sh/docs/chart_template_guide/notes_files/) to learn more about it.

### Edit the `values.yaml` file

Change the `service.image.version` value by the link to your public docker image as well, as the service port exposed.

```yaml
...
service:
  image:
    version: "ghcr.io/terriajs/terriamap:0.0.8"
...
networking:
  ...
  service:
    port: 3001
...
```

### Edit the `values.schema.json` file

Replace the Docker image links by the one you provided above as well as the service port.

```json
{
    ...
    "properties": {
        "service": {
            ...
            "properties": {
                "image" : {
                    ...
                    "properties": {
                      "version": {
                        ...
                        "listEnum": [
                            "ghcr.io/terriajs/terriamap:0.0.8"
                        ],
                        ...
                        "default": "ghcr.io/terriajs/terriamap:0.0.8"
                      }
                    }        
                }
            }
        },
        "networking": {
          ...
          "properties": {
            "service": {
              ...
              "properties": {
                "port": {
                  ... 
                  "default": 3001
                }
              }
            }
          }
        },
    ...
```

### Update the Makefile

Add a Make command to push your chart:

```Makefile
push-chart-terriamap-copy-example: CHART_DIRECTORY = terriamap-copy-example/
push-chart-terriamap-copy-example: push-chart

push-all-charts:
  ...
  $(MAKE) push-chart-terriamap-copy-example
```

### Create a merge request

Create a merge request on the repository and ping @pub/edito-infra/codeowners in the description to catch our attention.
Once it is merged, your chart will automatically be pushed and accessible on EDITO datalab.
