# How to run NEMO model on EDITO

## Launch the dedicated service
Start by going to the [ocean processes catalog](https://datalab.dive.edito.eu/catalog/ocean-processes), and launch the **Nemo-run-and-served** process.

![Launch](launch.gif)

Once NEMO has finished running, you will have access to two services:
- *Thredds* will served the output though the WMS protocol.
- *TerriaMap* will display the data.

## Open Thredds
Click the first link and navigate to `nemo_output.nc`, then click `WMS`. You will see the content of the **GetCapabilities** request. 

Copy the url until the first `?` (not included). Then go back to your running services.

![Thredds](thredds.gif)

## Open TerriaMap viewer
Click the second link and click on `Upload`, then `Add Web Data`. 

In the first dropdown menu, select **Web Map Service (WMS) Server**, and copy the link in the textbox. Click `Add`.

Click on `THREDDS` to see the *Temperature* variable. Click on the `+` sign to add it to the map.

The data is displayed!

![Viewer](viewer.gif)
