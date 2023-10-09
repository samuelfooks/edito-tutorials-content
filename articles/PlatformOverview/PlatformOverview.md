# EDITO Platform Overview
## Homepage

![](assets/1-Homepage.mp4)

- Headers containing links to all the important pages.
- Different languages and display mode.
- Main features focused at the bottom of the page.

## Tutorials

![](assets/2-Tutorials-Read.mp4)

Read tutorials to learn about the platform and its functionalities. 

![](assets/11-Tutorials-run-service.mp4)

Run tutorials with services directly opened in the datalab .

## Datalab
### Services Catalog

![](assets/3-Datalab-Services-Catalog.mp4)

Different tabs are available depending on the kind of services inside them:
- IDE
    - Jupyter
    - Rstudio
    - VsCode
    - ...
- Databases
    - Postgres
    - Mongo
    - ...
- Automation
- ModelLab
    - jupyterlab-autosubmit-bsc


### Authentication

![](assets/4-Datalab-Authentification.mp4)

Create an account to be able to launch services:
- Click on "Login" (top right corner of the page).
- Create an account.
- Validate mail (if no mail arrives in the first minute, check spam then click the button to send it again).


### Launching a service

![](assets/5-Datalab-Launch-Service.mp4)

In the service catalog, access the desired service and click on "Launch", a configuration page will appear.
Tabs are available to change the default configuration:
- Resources: default is more than enough, if you need more please keep us updated and scale it with measure.
- Git: to specify a repository branch and have it already checked out.
- Init: to add an initialization script run at the start of the service.
- S3: a personal file storage automatically available inside services.
- Vault: personal secrets storage automatically available inside services.
- Bookmark: save your specific configuration to directly launch pre-configured services.

Once the configuration is done, launch the service.

To access the service you need to copy the secret token provided. If you added a git repository in the configuration step you can see its content is already checked out.

### My Services

![](assets/6-Datalab-My-Services.mp4)

Display all your personal services running.
If you saved some configurations they are available on the right of the window.

### My Secrets

![](assets/7-Datalab-My-Secrets.mp4)

A personal secret storage, to add a new secret:
- Create a secret.
- Name it then double click to write your password into it.
    - Add a new variable and name it.
    - Write the secret corresponding to the named variable.

You can then access a launched service to check your secrets availability:
    - Copy the code snippet at the top right of the panel and use it in a launched service.
    
### My Files

![](assets/8-Datalab-My-Files.mp4)

A personal file storage, to add a file:
- Select upload or drag and drop your file in the pop-up window.

You can check your access to this file by copying the code snippet at the top right of the panel and use it in a launched service.

### My Account

![](assets/9-Datalab-My-Account.mp4)

Browse the settings and parameters of "My Account":
- external services:
    - Git configuration: here you can add a personal access token to interact with private repository.
- interface preferences: change your preferences such as light or dark mode and language.


### Additional Functionalities

#### Init Service

![](assets/10-Datalab-Additional-Init.mp4)
To add an init script at the start of a services you need to indicate the script url. To use one in your S3 personal storage "My Files":
- In "My Files" double click on the file to obtain its url (code snippet at the top right corner of the panel).
- Copy the url.
- Configure a new service with the init tab field containing the url from S3.
- Launch the service and check the installation worked.

Following is an init script example to install the Copernicus Marine Client:
[CopernicusMarineClientInstall.sh](assets/CopernicusMarineClientInstall.sh)
