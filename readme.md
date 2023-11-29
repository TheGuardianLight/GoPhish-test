# Script d'installation de GoPhish

Ce présent script installera le logiciel GoPhish, logiciel utilisé par les administrateurs pour créer des campagne de Phish à but de sensibilisation.

## Instruction d'utilisation

Pour commencer l'installation du script, suivez les étapes suivant :

1. Cloner ce dépot avec `git clone https://TheGuardianLight/GoPhish` dans un répertoire de travail quelconque (comme le répertoire root)
2. Une fois le dépot clôné, se déplacer dans le dossier du dépôt : `cd GoPhish`
3. Modifier les permissions du script afin qu'il soit exécuté : `chmod +x gophish.bash`
4. Suivre les instructions donné par le script et répondre aux questions posé.

Une fois que le script aura terminé l'installation et aura lancé le logiciel, celui-ci indiquera dans le terminal l'identifiant administrateur par défaut ainsi que son mot de passe qui sera temporaire et qui vous sera demandé lors de la première connexion de modifier.

5. Une fois que le mot de passe administrateur sera changé, faites `ctrl + c` pour fermer GoPhish dans le terminal ce qui permettra au script de finaliser l'installation.
6. Dés que l'installation sera terminé, vous pourrez lancer GoPhish avec la commande `systemctl start gophish`.

-----------------

**Date de création du script :** 28/11/2023

**Créateur du script :** Noa LEDET
