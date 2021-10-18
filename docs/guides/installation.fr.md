---
title: Installer Rocky Linux
---

# Installer Rocky Linux

Ce guide passe en revue les étapes détaillées pour installer une version 64 bits de la distribution rocky Linux sur un système autonome.

****
Dans ce chapitre, nous allons effectuer une installation de type serveur à l'aide d'une image d'installation du système d'exploitation téléchargée depuis le site Web du projet Rocky. Nous allons aborder les étapes d'installation et de personnalisation dans les sections suivantes.
****

!!! Note Wherever there is a command which is run from the command prompt it will be assumed that you are logged in as a standard user (not the superuser). The command to type will not show the command prompt which could be different depending on the system and operating system you are using.

## Prérequis à l'installation du système d'exploitation

La dernière image ISO de la version de Rocky qui sera utilisée pour cette installation peut être téléchargée ici :

Pour télécharger l'ISO directement depuis la ligne de commande, saisir :

```
https://www.rockylinux.org/download/
```

Les ISOs de Rocky sont nommées en suivant cette convention :

```
$ wget https://download.rockylinux.org/pub/rocky/8.4/isos/x86_64/Rocky-8.4-x86_64-minimal.iso
```

Par exemple `Rocky-8.4-x86_64-minimal.iso`

```
Rocky-<MAJOR#>.<MINOR#>.<ARCH>-<VARIANT>.iso
```

For example, `Rocky-8.4-x86_64-minimal.iso`

!!! Note La page web du projet Rocky propose une liste de nombreux miroirs situés partout dans le monde. A chaque fois que cela est possible, vous devriez choisir le miroir géographiquement le plus proche de vous. La liste des miroirs officiels peut être consultée [ici](https://mirrors.rockylinux.org)

## Vérifier l'ISO d'installation

Si vous avez téléchargé l'ISO(s) Rocky depuis une distribution Linux existante, vous pouvez utiliser l'utilitaire `sha256sum` pour vérifier que le(s) fichier(s) téléchargés ne sont pas corrompus. Nous allons montrer un exemple de la façon de vérifier le sha256sum renvoyé par la commande `sha256sum Rocky-8.4-x86_64-minimal.iso`.

Tout d'abord téléchargez le fichier contenant les sommes de contrôle officielles pour les ISOs disponibles. Toujours dans le répertoire contenant l'ISO de Rocky qui a été téléchargée, saisir :

```
wget http://download.rockylinux.org/pub/rocky/8.4/isos/x86_64/CHECKSUM
```

La sortie devrait contenir :

```
sha256sum -c CHECKSUM    --ignore-missing Rocky-8.4-x86_64-minimal.iso
```

The output should show:

```
Rocky-8.4-x86_64-minimal.iso: OK
```

## L'installation

!!! Tip "Astuce" Avant de démarrer l'installation à proprement parler, l'UEFI (Unified Extensible Firmware Interface) ou le BIOS (Basic Input/Output System) du système doit être configuré pour démarrer sur le bon média.

Insérez et démarrez le média d'installation (disque optique, clef USB, etc.).

Une fois démarré, vous verrez apparaître un écran de bienvenue.

Once the computer has booted you will be presented with the Rocky Linux 8 welcome splash screen.

![Rocky Linux installation splash screen](images/installation-F01.png)

Une fois que vous êtes satisfait de vos choix pour les différentes tâches d'installation, l'étape suivante du processus d'installation consiste à commencer l'installation à proprement parler.

`<code>Si vous n'appuyez sur aucune touche, l'invite va commencer un compte à rebours, après lequel le processus d'installation va démarrer avec l'option mise en évidence <code>Test this media & install Rocky Linux 8`.</code>

Cliquez sur <kbd>Fait</kbd> lorsque vous avez terminé.

Une étape de vérification rapide du support aura lieu. Cette étape de vérification du support peut vous éviter de lancer une installation pour vous rendre compte à mi-chemin que le programme d'installation va s'interrompre à cause d'un mauvais support d'installation.

L'écran est divisé selon les sections suivantes :

Sélectionnez dans cet écran la langue que vous voulez utiliser pour réaliser l'installation. Pour cet exemple, nous choisissons _Français (France)_. Cliquez ensuite sur le bouton <kbd>Fait</kbd>.

## Localisation

L'écran _Résumé de l'installation_ est un espace tout en un dans lequel vous prenez les décisions importantes sur le système d'exploitation à installer.

Sur le système de démonstration de ce guide, nous acceptons la valeur par défaut _Français (variante)_ sans faire de changement.

- _Localisation_ : Clavier, Support Langue et Heure & Date
- _Logiciel_ : Source d'installation et Sélection Logiciel
- _Système_ : Cible de l'installation et Réseau & Nom d'hôte

Examinons maintenant chacune de ces sections pour apporter des modifications si nécessaires.

### Clavier

Cette section permet de personnaliser les éléments liés aux paramètres régionaux du système. Cela inclut : le clavier, le support de la langue, l'heure et la date.

#### Keyboard

L'option <kbd>Support langue</kbd> de l'écran _Résumé de l'installation_ vous permet de spécifier la prise en charge de langues supplémentaires dont vous pourriez avoir besoin sur le système cible.

Toutefois, si vous avez besoin de faire des changements ici, depuis l'écran _Résumé de l'installation_, cliquez sur l'option <kbd>Clavier</kbd> pour spécifier la disposition du clavier de votre système. Vous pouvez ajouter d'autres dispositions de clavier si besoin dans l'écran suivant et spécifier leur ordre.

Cliquez ensuite sur <kbd>Fait</kbd> en haut de l'écran.

#### Language Support

Cliquez sur <kbd>Fait</kbd> pour revenir à l'écran principal _Résumé de l'installation_.

Dans la section _Logiciel_ de l'écran _Résumé de l'installation_, vous pouvez sélectionner la source d'installation ainsi que les paquets supplémentaires (applications) qui seront installés.

#### Time & Date

Cliquez sur l'option <kbd>Heure & Date</kbd> de l'écran principal _Résumé de l'installation_ pour faire apparaître un autre écran qui vous permettra de sélectionner le fuseau horaire dans lequel se trouve la machine. Faites défiler la liste des régions et des villes et sélectionnez la zone la plus proche de vous.

En fonction de votre source d'installation, l'option _Heure du réseau_ peut être réglée sur _ON_ ou _OFF_ par défaut. Acceptez le paramètre par défaut _ON_ ; cela permet au système de régler automatiquement la bonne heure en utilisant le protocole NTP (Network Time Protocol). Cliquez sur <kbd>Fait</kbd> après avoir effectué les modifications.

### Support de la langue

Sélectionnez plutôt l'option _Installation minimale_ (Fonctionnalité de base).

#### L'installation

Puisque nous effectuons notre installation à l'aide d'une image Rocky 8 complète, vous remarquerez que le _Média local_ est automatiquement spécifié dans la section _Source d'installation_ de l'écran principal _Résumé de l'installation_. Nous allons accepter les valeurs par défaut.

#### Software Selection

En cliquant sur l'option <kbd>Sélection Logiciel</kbd> de l'écran principal _Résumé de l'installation_, vous accédez à la section de l'installation où vous pouvez choisir les paquets logiciels qui seront installés sur le système. La zone de sélection des logiciels est divisée en deux parties :

- _Environnement de base_ : Serveurs, Installation minimale, Système d'exploitation personnalisé
- _Logiciel supplémentaire pour l'environnement sélectionné_ : la sélection d'un environnement de base sur le côté gauche présente une variété de logiciels supplémentaires connexes qui peuvent être installés pour l'environnement donné sur le côté droit.

Dans la section _Configuration du stockage_, sélectionnez l'option <kbd>Automatique</kbd>.

Cliquez sur <kbd>Fait</kbd> en haut de l’écran.

### Heure & Date

La section Système de l'écran _Résumé de l'installation_ est utilisée pour personnaliser et modifier le matériel sous-jacent du système cible. C'est ici que vous créez vos partitions ou volumes de disque dur, que vous spécifiez le système de fichiers à utiliser et que vous spécifiez la configuration du réseau.

#### Finir l'installation

Depuis l'écran _Résumé de l'installation_, cliquez sur l'option <kbd>Destination de l'installation</kbd>. Vous accédez alors à la zone de tâches correspondante.

Vous verrez un écran affichant tous les disques candidats disponibles sur le système cible. Si vous n'avez qu'un seul disque sur le système, comme sur notre système de démonstration, vous verrez le disque répertorié sous _Disques locaux standards_ avec une case à cocher à côté. En cliquant sur l'icône du disque, vous pourrez activer ou désactiver la coche de sélection du disque. Nous voulons qu'elle soit sélectionnée/cochée ici.

La dernière tâche de la procédure d'installation concerne la configuration du réseau, où vous pouvez configurer ou modifier les paramètres liés au réseau pour le système.

Cliquez sur <kbd>Fait</kbd>.

Une fois que le programme d'installation aura déterminé que votre disque est utilisable, vous serez renvoyé à l'écran _Résumé de l'installation_.

### Source d'installation

The final task of the installation procedure deals with network configuration, where you can configure or tweak network-related settings for the system.

!!! Note Après avoir cliqué sur l'option <kbd>Réseau et nom d'hôte</kbd>, tous les matériels de type interface réseau correctement détectés (tels que les cartes réseau Ethernet, sans fil, etc.) seront répertoriés dans le volet gauche de l'écran de configuration du réseau. Selon la distribution Linux et la configuration matérielle spécifique, les périphériques Ethernet sous Linux ont des noms similaires à `eth0`, `eth1`, `ens3`, `ens4`, `em1`, `em2`, `p1p1`, `enp0s3`, etc.

Pour chaque interface, vous pouvez soit la configurer en utilisant DHCP, soit définir manuellement l'adresse IP. Si vous choisissez de la configurer manuellement, assurez-vous de disposer de toutes les informations nécessaires, telles que l'adresse IP, le masque de réseau, etc.

En cliquant sur le bouton <kbd>Réseau et nom d'hôte</kbd> dans l'écran principal _Résumé de l'installation_, vous ouvrez l'écran de configuration correspondant. Vous avez entre autres la possibilité de configurer le nom d'hôte du système (le nom par défaut est `localhost.localdomain`).

!!! Note Vous pourrez facilement modifier ce nom plus tard, une fois le système d'exploitation installé. Pour le moment, acceptez la valeur par défaut fournie pour le nom d'hôte.

La prochaine tâche importante de configuration concerne les interfaces réseau du système. Tout d'abord, vérifiez qu'une carte Ethernet (ou toute autre carte réseau) est répertoriée dans le volet de gauche. Cliquez sur l'un des périphériques réseau détectés dans le volet de gauche pour le sélectionner. Les propriétés configurables de la carte réseau sélectionnée apparaissent dans le volet droit de l'écran.

!!! Note Sur notre serveur de démonstration, nous avons quatre périphériques Ethernet (`ens3`, `ens4`, `ens5` et `ens6`), qui sont tous dans un état connecté. Le type, le nom, la quantité et l'état des périphériques réseau de votre système peuvent varier de ceux de notre système de démonstration.

Assurez-vous que l'interrupteur du périphérique que vous souhaitez configurer est activé dans le panneau de droite. Nous accepterons toutes les valeurs par défaut dans cette section.

Cette section peut être utilisée pour créer un mot de passe pour le compte administrateur `root` mais également pour créer de nouveaux comptes administrateurs ou simples utilisateurs.

!!! Warning "Attention" Faites attention à l'adresse IP du serveur dans cette section du programme d'installation. Si vous ne disposez pas d'un accès physique ou d'un accès facile à la console du système, cette information vous sera utile ultérieurement lorsque vous devrez vous connecter au serveur pour continuer à travailler sur celui-ci.

## Section Logiciel

Once you are satisfied with your choices for the various installation tasks, the next phase of the installation process will begin the installation proper.

### Sélection Logiciel

Saisissez à nouveau le même mot de passe dans la zone de texte _Confirmer_.

### Destination de l'installation

Cliquez sur le champ <kbd>Mot de passe administrateur</kbd> (mot de passe de `root`) sous _Paramètres utilisateur_ afin de lancer l'écran de gestion _Mot de passe administrateur_ (mot de passe `root`). Dans la zone de texte _Mot de passe administrateur_, définissez un mot de passe complexe pour l'utilisateur `root`.

!!! Warning "Attention" Cet utilisateur est le compte disposant du plus de droits sur le système. Par conséquent, si vous choisissez de l'utiliser ou de l'activer, il est crucial que vous protégiez ce compte avec un très bon mot de passe.

Enter the same password again in the _Confirm_ text box.

Nous allons créer un utilisateur ordinaire qui pourra invoquer les pouvoirs du superutilisateur (administrateur) en cas de besoin.


### Réseau et nom d'hôte

Cliquez ensuite sur l'option <kbd>Création Utilisateur</kbd> sous _Paramètres utilisateur_ pour lancer l'écran de gestion _Créer un utilisateur_. Cette zone de gestion vous permet de créer un compte utilisateur privilégié ou non privilégié (non administrateur) sur le système.

!!! Info Créer et utiliser un compte sans privilège pour les tâches quotidiennes sur un système est une bonne pratique d'administration du système.

_Nom d'utilisateur_ : `rockstar`

_Faire de cet utilisateur un administrateur_ : Coché

_Exiger un mot de passe pour utiliser ce compte_ : Coché

_Mot de passe_ : `04302021`

_Confirmer le mot de passe_ : `04302021`

_Nom et prénom_ : `rockstar`

_Password_: `04302021`

Lorsque l'installation commence, différentes tâches démarrent en arrière-plan, comme le partitionnement du disque, le formatage des partitions ou des volumes LVM, la vérification et la résolution des dépendances logicielles, l'écriture du système d'exploitation sur le disque, etc.

### Configurer le mot de passe administrateur

Une fois que vous êtes satisfait de vos choix pour les différentes tâches d'installation, cliquez sur le bouton <kbd>Commencer l'installation</kbd> de l'écran principal _Résumé de l'installation_. L'installation commencera, et le programme d'installation affichera la progression de l'installation.

!!! Note Si vous avez peur après avoir cliqué sur le bouton <kbd>Commencer l'installation</kbd>, vous pouvez toujours faire marche arrière en toute sécurité sans perdre vos données (ou votre amour-propre). Pour quitter le programme d'installation, il suffit de réinitialiser votre système en cliquant sur le bouton <kbd>Quitter</kbd>, en appuyant sur la touche <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Suppr</kbd> du clavier, ou en appuyant sur le bouton d'alimentation.

When the installation begins, various tasks will begin running in the background, such as partitioning the disk, formatting the partitions or LVM volumes, checking for and resolving software dependencies, writing the operating system to the disk, and so on.

### Création Utilisateur

Une fois que les sous-tâches obligatoires sont terminées et que le programme d'installation a suivi son cours, un écran final _Progression de l'installation_ est affiché avec un message de fin.

Enfin, terminez la procédure en cliquant sur le bouton <kbd>Redémarrer le système</kbd>. Le système redémarrera de lui-même.

### Démarrer l'installation

Le système est maintenant configuré et prêt à être utilisé. Vous verrez l'adorable console Rocky Linux.

![Rocky Linux Welcome Screen](images/installation-F04.png)

Pour se connecter au système, saisissez `rockstar` au prompt de connexion et appuyer sur <kbd>Entrer</kbd>.

Au prompt du mot de passe, saisissez `04302021` (le mot de passe de rockstar) et appuyer sur <kbd>Entrer</kbd>.

Nous lançons la commande `whoami` après la connexion.

![Login Screen](images/installation-F06.png)
