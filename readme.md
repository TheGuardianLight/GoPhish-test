# Script d'installation de GoPhish

Ce présent script installera le logiciel GoPhish, logiciel utilisé par les administrateurs pour créer des campagne de Phish à but de sensibilisation.

## Instruction d'utilisation

Pour débuter l’installation du script, voici les instructions à suivre :

1. Effectuez un clone de ce dépôt en utilisant la commande : `git clone https://TheGuardianLight/GoPhish`. Vous pouvez le faire dans n’importe quel répertoire de travail (par exemple, le répertoire root).

2. Après avoir cloné le dépôt, naviguez jusqu’au dossier du dépôt avec la commande : `vcd GoPhish`

3. Ajustez les permissions du script pour qu’il puisse être exécuté en utilisant la commande : `chmod +x gophish.bash`

4. Suivez les directives fournies par le script et répondez aux questions qui vous seront posées.

Lorsque le script aura achevé l’installation et démarré le logiciel, il affichera dans le terminal l’identifiant administrateur par défaut ainsi que son mot de passe temporaire. Vous serez invité à modifier ce mot de passe lors de votre première connexion.

5. Une fois le mot de passe administrateur modifié, utilisez `ctrl + c` pour fermer GoPhish dans le terminal. Cela permettra au script de finaliser l’installation.

6. Lorsque l’installation sera complète, vous pourrez démarrer GoPhish avec la commande : `systemctl start gophish`

-----------------

**Date de création du script :** 28/11/2023

**Créateur du script :** Noa LEDET
