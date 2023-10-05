# How to add new content

For now, it is only possible to add new content by creating a pull request on [this public gitlab repository](https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content).

To add a new tutorial, you'll only need to add a new entry in the root list of the `tutorials.json` file at the root of this project.

## Create an article

An article is just a tile on the ["tutorials" interface](https://tutorials.digitaltwinocean.edito.eu/formation), that you can "Read" (by clicking on the "Read" button). It'll redirect you to the URL defined in the `articleUrl` section of the following JSON.

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
    "tags": [
        "discover", // A list of tags. For now, there's only 3 available tags you can choose: "discover", "learn" and "consolidate"
        "learn",
        "consolidate"
    ],
    "category": "discover the datalab",  // For now, you'll only be able to choose between: "best practices", "discover the datalab", "training courses in data science", "training courses with python" and "training courses with R"
    "imageUrl": "https://www.edito.eu/wp-content/uploads/2023/09/favicon.png",
    "articleUrl": {
        "fr": "https://my/tutorial/fr/page.html", // the url of your tutorial
        "it": "https://my/tutorial/it/page.html",
        "en": "https://my/tutorial/en/page.html",
    }
},
```

If you can't host your article.html on the web, we allow you to add a markdown file under the articles directory of this project and reference it under the `articleUrl` section with the following prefix path : `https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/-/blob/master/articles/myNewArticle.md`.
