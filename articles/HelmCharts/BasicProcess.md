# Add your own computation as a Process
Please be aware that this feature is in a beta state and as such not yet fully available in the datalab. However they can be accessed thanks to this [hidden tab](https://datalab.digitaltwinocean.edito.eu/catalog/oceanprocesses).

## What is a process ?
In order to have a broad compatibility, we chose to follow standard, and in the case of computation the [OGC API - process](https://ogcapi.ogc.org/processes/) corresponded to our needs. Their definition of a process is the following "The OGC API - Processes standard supports the wrapping of computational tasks into executable processes that can be offered by a server through a Web API and be invoked by a client application. The standard specifies a processing interface to communicate over a RESTful protocol using JavaScript Object Notation (JSON) encodings. Typically, these processes execute well-defined algorithms that ingest vector and/or coverage data to produce new datasets."

## Contribution steps
To add any process to our platform, you will have to make a merge request to one of our repositories. For all processes pertaining to the Ocean domain please use the [Ocean Processes](https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-processes) repository. If your are not sure of the repository to target, please use the [Playground Helm Charts](https://gitlab.mercator-ocean.fr/pub/edito-infra/playground-helm-charts) repository.  

This tutorial provides guidelines to create your own helm chart in order to deploy a container image on the EDITO datalab. Do not hesitate to look at other charts to get inspired. In our example we use Python but any language can be used to create a process. Please adapt the python references to the other languages if needed.

First thing first, you will need to have a container image hosted on a public repository. This image should run a container exposing environment variables to determine inputs and outputs location, if they are needed. No volume should be mounted for input, a temporary volume can be used to harvest the process output.

In this tutorial, we will take the [Coral bleaching detection process](https://datalab.digitaltwinocean.edito.eu/launcher/oceanprocesses/coral-bleaching-job) as an example. At the time being, it only has one input parameter determining if the process is launched as a small demonstration (small resources needed to run).

And as you can see, this project satisfies the minimal requirement for hosting a process on the datalab, which is having a public container image available with environment variables if an input is needed.

## Containerizing your computation code
In order to containerize our computation code, we used Docker.
If needed, please read the documentation to know more about getting started with [Docker](https://docs.docker.com/get-started/). In case you are using python together with a micromamba environment, [micromamba quick start](https://micromamba-docker.readthedocs.io/en/latest/quick_start.html) can be of help. 

As a further example, here is one of our Dockerfile using python with a micromamba environment:
```Dockerfile
FROM mambaorg/micromamba:1.4.1-kinetic

COPY --chown=$MAMBA_USER:$MAMBA_USER ./conda_environment_bleaching.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

COPY ./bleaching.py /bleaching.py

CMD [ "python", "/bleaching.py" ]
```

The important points to follow is that you will need to reproduce the steps you are doing manually inside the Dockerfile in order for your code to be able to run. So all dependencies must be installed, via an environment manager, a dependency manager or one by one.
Furthermore the input must be made available via an environment variable, either its whole content or an URL to access it, and used accordingly into your code.
At last you must launch your code, as done in the example with `CMD [ "python", "/bleaching.py" ]`.

## Python use of environment variable
In order to use the environment variables inside the python code, only the built-in "os" library is needed.
In this project the input is a boolean named "SMALL_DEMO" and used inside the python code to limit the quantity of data used for the demonstration.
```python
import os

os.environ.get("SMALL_DEMO")
```

## Clone the repository

```sh
git clone https://gitlab.mercator-ocean.fr/pub/edito-infra/ocean-processes.git
```

## Create your own chart folder

You can start by copying the content `coral-bleaching-job` folder inside your own folder.

```sh
cp coral-bleaching-job my-process
```

## Update the chart configuration

### Edit the `Chart.yaml` file

Change the following fields and **leave the others unchanged**:

- name (the name of your process, using only alphanumerical characters without spaces. Also known as [kebab-case](https://en.wikipedia.org/wiki/Naming_convention_(programming)) convention)
- description (a brief description of your process)
- icon (an image that represent the underlying process) 
- keywords (a list of useful keywords that can be used to retrieve your process from the datalab search bar)
- version (the version of the chart. Starts with 1.0.0 and update later if you need some changes)
- appVersion (the version of the process running inside your docker container. Maybe a version of your computation is present inside the repository where your process is versioned)

**All of these attributes are mandatory**, please find an icon even a generic one to illustrate your process.

### Edit the `templates/NOTES.txt` file

The content will be rendered and displayed in a pop-up window while the process is being launched. This text targets any user discovering your process. If you have an estimation of the time needed for the process to complete, it could be an interesting information to add.
By default the name of your process will be indicated if you keep the original notes, you can have access to Helm values such as `{{ .Chart }}`, `{{ .Release }}`, etc., as you can see in our example.
You can use other Helm values in this template file. Please take a look at the official [Helm documentation](https://helm.sh/docs/chart_template_guide/notes_files/) to learn more about it.

### Edit the `values.yaml` file

Replace the input environment variable "smallDemo" by your own and its default value, or add new ones. If you need an output environment variable, add a "processOutputs" section at the bottom with its name. As you can see, this named variable is not exactly the same one as the name from the python code. The correspondence will be done in a further step.

```yaml
...
processInputs:
  smallDemo: true
...
```

### Edit the `values.schema.json` file

Replace into the file the input information by your own and add any necessary according to the environment variables you put into `value.yaml`.

```json
{
    ...
        "processInputs": {
          "description": "Process inputs",
          "type": "object",
          "properties": {
            "smallDemo": {
              "type": "boolean",
              "description": "To run a small demo of the process",
              "default": true
            }
          }
        }
    ...
}
```

### Edit the `templates/job.yaml` file
Replace the container image reference `image: docker.mercator-ocean.fr/moi-docker/bleaching:1.0.1` by your own. Replace or add the environment variables by precising their names and values. The easiest way is to use the Helm values to directly inject the value of the environment variable in this way : `"{{ .Values.processInputs.smallDemo }}"`.
As you can see, the link between the environment variables and the names used inside the `values.yaml` file is indicated here.
 ```yaml
        env:
        - name: SMALL_DEMO
          value: "{{ .Values.processInputs.smallDemo }}"
 ```

## Create a merge request

Create a merge request on the repository and ping @pub/edito-infra/codeowners in the description to catch our attention.
Once it is merged, your chart will automatically be pushed and accessible on EDITO datalab.