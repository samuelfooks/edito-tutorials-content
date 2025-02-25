# How to add new content

For now, it is only possible to add new content by creating a pull request on [this public gitlab repository](https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content).

To add a new tutorial, you'll only need to add a new entry in the root list of the `tutorials.json` file at the root of this project.

## Create an article

An article is just a tile on the ["tutorials" interface](https://dive.edito.eu/training), that you can "Read" (by clicking on the "Read" button). It'll redirect you to the URL defined in the `articleUrl` section of the following JSON.

A tile also has the ability to launch a pre-configured service directly in the datalab. You can "Run" this service (by clicking on the "Run" button). It'll redirect you to the URL defined int the `deploymentUrl` section of the following JSON, as if you launched a preconfigured service from "My Services". You should configure a specific service in the datalab, save its configuration,test it and then add its URL to your tuturial.
```json
{
    "name": {
        "fr": "Le nom de votre article en français",
        "it": "Il nome del tuo articolo in italiano",
        "en": "The name of your article in english"
    },
    "abstract": {
        "fr": "Une description courte de votre article",
        "it": "Una breve descrizione del tuo articolo",
        "en": "A short description of your article"
    },
    "authors": [
        "The authors's names"
    ],
    "types": [
        "types": [
          {
            "fr": "Tutoriel",
            "it": "Tutorial",
            "en": "Tutorial"
          }
    ],
    "tags": [ // A list of tags. For now, there's only 3 available tags you can choose: "discover", "learn" and "consolidate"
        "explore", // If your tutorial does not require user authentication
        "create", // If your tutorial allow the user to create content on EDITO
        "contribute" // If your tutorial allow the user to build and publish content on EDITO
    ],
    "category": "discover EDITO",  // For now, you'll only be able to choose between:  "Ocean modelling", "Ocean data quality", "Data visualization", "What-If applications", "Focus applications", "discover EDITO", "training courses in data science", "training courses with python", "training courses with R" and "best practices",
    "imageUrl": "https://www.edito.eu/wp-content/uploads/2023/09/favicon.png",
    "articleUrl": {
        "fr": "https://my/tutorial/fr/page.html", // the url of your tutorial
        "it": "https://my/tutorial/it/page.html",
        "en": "https://my/tutorial/en/page.html",
    }
    "deploymentUrl": "https://datalab.dive.edito.eu/launcher/"// the url of your pre-configured service
    // parts: [] 
},
```

If you can't host your article.html on the web, we allow you to add a markdown file under the articles directory of this project and reference it under the `articleUrl` section with the following prefix path : `https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/-/blob/master/articles/myNewArticle.md`.

You can organized your articles with sub-sections if desired. To do that, instead of having article or deployment links, add a `parts` keys containing the lists of your articles/tutorials. You can compose sub-section if wanted, meaning articles that are part of a `parts` list can also have `parts` keys.

## Create a Merge Requests

Create a Merge Requests against branch `master` and ping [@pub/edito-infra/codeowners](https://gitlab.mercator-ocean.fr/pub/edito-infra/codeowners) to request code owners to review your proposal.
