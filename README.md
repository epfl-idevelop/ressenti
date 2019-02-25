# ressenti


## Buts
Mesure le ressenti (durée) d'un utilisateur au chargement d'une page web complexe


## Méthode
On mesure le temps de chargement d'une page avec le browser Firefox en mode headless et on la sauve dans un fichier.

Ainsi on est certain que la page a été chargée avec tous les objets et pas seulement le code HTML.

On peut aussi par la suite comparer les screenshots pour détecter une anomalie ou changement sur la page.


## Installation
(c'est confu, mais c'est pour moi pour me souvenir après coup, et c'est provisoire en attendant d'avoir une meilleure solution)
Pour que 'ressenti' puisse publier sur la gateway Prometheus du NOC de la FSD il faut creuser en premier quelques tunnels SSH:

1) sur le MAC en excéqutant le script ssh-tunnels-noc-fsd.sh, qui va permettre de partager le port du gateway Prometheus du NOC sur mon MAC avec un ssh reverse puis en l'envoyant sur la machine VM Ubuntu

2) sur la machine VM Ubuntu, il faut creuser un tunnel ssh '-g' avec le script make_ssh_tunnels.sh, afin de l'exporter au container Docker 'ressenti', ainsi il utilise l'adresse ip externe de la VM Ubuntu


## Autres pistes à tester
Depuis Firefox 58, et Chrome 57, ont été introduits le `Navigation Timing`. Il s'agit d'une propriété expérimentale de JavaScript 
implicitement et automatiquement mise à jour. Tout au long du chargement du document, des temps sont mesurés et stockés dans 
certaines variables built-in de JS. Nous n'avons qu'à les lire. 

Donc à tester:<br>
https://developer.mozilla.org/en-US/docs/Web/API/Navigation_timing_API




zf190225.1618

