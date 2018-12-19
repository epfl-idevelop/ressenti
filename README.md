# ressenti
## But
Mesure le ressenti (durée) d'un utilisateur au chargement d'une page web complexe


## Méthode
On mesure le temps de chargement d'une page avec le browser Firefox en mode headless et on la sauve dans un fichier.

Ainsi on est certain que la page a été chargée avec tous les opbjets et pas seulement le code HTML.

On peut aussi par la suite comparer les screenshots pour détecter une anomalie ou changement sur la page.

### Autre piste
Depuis Firefox 58, et Chrome 57, ont été introduits le `Navigation Timing`. Il s'agit d'une propriété expérimentale de JavaScript 
implicitement et automatiquement mise à jour. Tout au long du chargement du document, des temps sont mesurés et stockés dans 
certaines variables built-in de JS. Nous n'avons qu'à les lire. 

Donc à tester:<br>
https://developer.mozilla.org/en-US/docs/Web/API/Navigation_timing_API




zf181219.1510

