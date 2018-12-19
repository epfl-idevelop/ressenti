# ressenti
## But
Mesure le ressenti (durée) d'un utilisateur au chargement d'une page web complexe


## Méthode
### La mauvaise
La méthode la plus naturelle est la suivante:
```
loop:
    start = get-time()
    get("http://thepage")
    end = get-time()
    print(end-start)
```

Cependant, Selenium ne convient pas à cette méthode car `get` n'est pas bloquant et pourrait retourner avant d'avoir chargé toute la page.

 Les essais avec cette méthode n'ont d'ailleurs pas été concluants. En effet, un simple run retournait des résulats d'environ 10-15 secondes, ce qui est clairement faux. Ensuite lorsque nous avons tenté de rajouter une boucle infinie autour de ce process, deux cas se sont présentés:
+ Lorsque seuls les éléments ci-dessus étaient dans la boucle, les temps affichés sont devenus **dégressifs** : de 12 secondes, ils sont tombés à 0.3 secondes après quelques itérations. Clairement, un processus de cache est à l'œuvre ici.
+ Nous avons aussi tenté de mettre tout le processus dans une boucle, mais les temps sont devenus alors devenus **progressifs**: pour 12 secondes à la première boucle, ils ont grimpés jusqu'à _210 secondes_, puis sont retombés vers 75 secondes, et ont oscillé entre 50 et 80.

Il est clair qu'aucun de ces résultats n'est convenant.

### La meilleure
Depuis Firefox 58, et Chrome 57, ont été introduits le `Navigation Timing`. Il s'agit d'une propriété expérimentale de JavaScript implicitement et automatiquement mise à jour. Tout au long du chargement du document, des temps sont mesurés et stockés dans certaines variables built-in de JS. Nous n'avons qu'à les lire. 