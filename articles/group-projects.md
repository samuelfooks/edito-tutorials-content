# EDITO group projects

EDITO incorporates a feature that allows multiple users to share access to the same resources within a project.
While this can be extremely beneficial for collaboration, be aware that it might be exploited by a malicious user within the group to leverage the privileges of another project member.
**Always monitor shared resources and maintain proper user access control to prevent such security breaches**.

## Datalab

### Secrets

**!!! PLEASE READ CAREFULLY !!!**

All members of a group project can access the group project secrets from self-services launched in their personal project or from the group project.
The access is associated to their personal vault token.
The group project does not have a vault token.

**WE DO NOT RECOMMEND ASSOCIATING A VAULT TOKEN WITH SHARED SERVICES**, otherwise other members of the group project could access your secrets.
We recommend configuring the service to accept secrets in a dedicated configuration tab (at launch time), instead.

On top-left part of the Datalab, you can now change the current context from your personal project to a shared group project you have been added to.
Below are the fundamental changes between personal projects and group projects.

### Project settings

The project settings are shared with all the group project members.
If you add an S3 configuration (for example), it will be available to all members.

### Services

Any members of the group projects can launch a service.
The launched service will be launched in the name of the user but will run in the project namespace, with the resource configuration of the project.

#### Non-shared self-services

By default, the launched service will only be visible in "My Services" to the user that launched it.

#### Shared self-services

If at launch time option "share service" is enabled, the service will be visible in "My Services" by all the group project members.
**BE CAREFUL WITH THE VAULT TOKEN SPECIFIED IN CONFIGURATION**: as said above, **WE DO NOT RECOMMEND ASSOCIATING A VAULT TOKEN WITH SHARED SERVICES**.

### Files

The project files are shared with all the group project members.

### Group project administration

For now, group projects are only administrated by EDITO administrators. 

### Create a group project

Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need to create a group project.

### Add a new group project member

Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need to add a member to an existing group project.
