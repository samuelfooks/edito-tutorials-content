# Host your own web application

To add any service to our platform, you will have to make a pull request to our [Ocean Modelling Helm Charts](https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-modelling-helm-charts) repository. This tutorial provide the guideline to follow to create your own helm chart that can host a Docker image web application. Do not hesitate to look at other charts to get inspired.

First thing first, you will need to have a Docker image hosted on a public repository. This image should run a container exposing a web service through a port. 

In this tutorial, we will use [TerriaMap](https://github.com/TerriaJS/TerriaMap) viewer project as an example. As you can see in this [Dockerfile](https://github.com/TerriaJS/TerriaMap/blob/main/deploy/docker/Dockerfile), the port used for the node server is **3001**.

### Clone the repository 

```sh
git clone https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-modelling-helm-charts.git
```

### Create your own chart folder

You can start by copying the content `web-app-template` folder inside your own folder.
```sh
cp web-app-template terriamap
```

### Update the chart configuration

#### Edit the `Chart.yaml` file 
Change the following fields:
- name
- description
- icon
- keywords
- version
- appVersion

```yaml
apiVersion: v2
name: terriamap
description: Run a TerriaMap viewer server.
icon: https://github.com/TerriaJS/TerriaMap/raw/main/terria-logo.png
keywords:
  - Viewer
type: application
version: 1.0.0
appVersion: "8.3.0"
dependencies:
  - name: library-chart
    version: 1.5.16
    repository: https://inseefrlab.github.io/helm-charts-interactive-services
```

#### Edit the `templates/NOTES.txt` file 
The content will be rendered and displayed in a pop-up window while the service is being launched.
```txt
Your TerriaMap application is being deployed.

It will be available on this [link](http{{ if $.Values.ingress.tls }}s{{ end }}://{{ .Values.ingress.hostname }}).
```
As you may see, you can use Helm values in this template file. You can check the official [Helm documentation](https://helm.sh/docs/chart_template_guide/notes_files/) to learn more about it.

#### Edit the `values.yaml` file 
Change the `service.image.version` value by the link to your Docker image as well as the service port.
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

#### Edit the `values.schema.json` file 
Replace the three Docker image links by the one you provided above as well as the service port.
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
                      },
                      "custom" : {
                        ...
                        "properties": {
                          ...
                          "version": {
                            ...
                            "default": "ghcr.io/terriajs/terriamap:0.0.8",
                            ...
                          }
                        }        
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
push-chart-terriamap: CHART_DIRECTORY = terriamap/
push-chart-terriamap: push-chart

push-all-charts:
	...
	$(MAKE) push-chart-terriamap
```

### Create a merge request

Create a merge request on the repository (ping @pub/edito-infra/codeowners in the description). Once it is merged, your chart will automatically be pushed and accessible on EDITO datalab.