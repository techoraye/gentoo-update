# Gentoo-Update

> Un outil de notification et d'application des mises à jour pour Gentoo Linux

## Fonctionnalités

- 🚀 **Rapide et Efficace**: Écrit en C++ pour des performances optimales
- 🔄 **Synchronisation Automatique**: Synchronisation optionnelle des dépôts
- 📰 **Affichage des Nouvelles**: Consultez les actualités Gentoo directement
- 🔧 **Gestion des Services**: Vérifiez les services nécessitant un redémarrage
- ⚙️ **Hautement Configurable**: Personnalisez le comportement via fichier de config
- 🎨 **Support des Couleurs**: Sortie colorée avec option de désactivation
- 🔔 **Notifications de Bureau**: Recevez une notification des mises à jour disponibles
- 📦 **Détection de Reconstruction**: Alerte sur les paquets à reconstruire
- 💾 **Préservation des Paquets**: Configurez la rétention des anciens paquets
- 🖥️ **Systèmes Init Multiples**: Support pour systemd et OpenRC

## Installation

### Depuis les Sources

```bash
git clone https://github.com/Techoraye/gentoo-update.git
cd gentoo-update
mkdir build && cd build
cmake ..
make
sudo make install
```

## Utilisation

> **Note :** Si gentoo-update n'est pas installé système, définissez la variable d'environnement avant d'exécuter :
> ```bash
> export GENTOO_UPDATE_LIBDIR="./src/lib"
> ./gentoo-update [OPTIONS]
> ```

### Mode Interactif (Défaut)

```bash
gentoo-update
```

### Vérifier les Mises à Jour

```bash
gentoo-update -c
gentoo-update --check
```

### Lister les Mises à Jour

```bash
gentoo-update -l
gentoo-update --list
```

### Afficher les Nouvelles

```bash
gentoo-update -n
gentoo-update -n 10        # Affiche les 10 dernières nouvelles
```

### Vérifier les Services

```bash
gentoo-update -s
gentoo-update --services
```

### Gestion de la Configuration

```bash
gentoo-update --gen-config      # Génère la configuration par défaut
gentoo-update --show-config     # Affiche la configuration actuelle
gentoo-update --edit-config     # Édite la configuration
```

### Mode Barre Système

```bash
gentoo-update --tray                # Exécute en mode barre système
gentoo-update --tray --enable       # Active le démarrage automatique
gentoo-update --tray --disable      # Désactive le démarrage automatique
```

## Configuration

Fichier de configuration: `~/.config/gentoo-update/gentoo-update.conf`

Générez une configuration par défaut avec:
```bash
gentoo-update --gen-config
```

### Options Disponibles

| Option | Type | Défaut | Description |
|--------|------|--------|-------------|
| `NoColor` | booléen | false | Désactiver la sortie colorée |
| `AlwaysShow` | booléen | false | Toujours afficher la sortie complète |
| `NewsNum` | entier | 5 | Nombre d'actualités à afficher |
| `KeepOldPackages` | entier | 3 | Nombre d'anciennes versions à conserver |
| `DiffProg` | chaîne | vimdiff | Programme pour comparer les configs |
| `AutoSync` | booléen | true | Synchroniser automatiquement les dépôts |

## Pages de Manuel

Documentation complète disponible:

```bash
man gentoo-update           # Documentation principale
man gentoo-update.conf      # Format du fichier de configuration
```

## Auteur

**Mathieu Roberge (Techoraye)**
- Email: robergem2008@gmail.com
- GitHub: [@Techoraye](https://github.com/Techoraye)

## Licence

GNU General Public License v3.0 ou ultérieure

## Contributeurs Bienvenue

Voir [CONTRIBUTING.md](CONTRIBUTING.md) pour les directives de contribution.

---

**Documentation Complète**: Pour plus d'informations, consultez [README.md](README.md)
