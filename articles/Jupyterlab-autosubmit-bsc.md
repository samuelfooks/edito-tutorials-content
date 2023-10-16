# Using the Jupyterlab-autosubmit-bsc service

To be able to use the Jupyterlab-autosubmit-bsc service correctly, you will need to add your ssh private key to your secret storage inside the datalab "My Secrets":
- Log in to your account
- Access "My Secrets"
- At the root of your secret, create a new secret called "autosubmit"
- Inside this secret create a new variable named `SSH_PRIVATE_KEY` and paste its value in the field "value"
- Save this new variable by clicking on the check icon at the end of the line

Now that your secret exists you can click the "Run" button of this tutorial or launch the Jupyterlab-autosubmit-bsc services from the tab "ModelLab" in the "Services Catalog".

If you already launched the services before creating the secret, once the secret is created, you can update your service by running the following command inside it:
`load_ssh_key `