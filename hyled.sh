#!/bin/bash

# Fonction pour vérifier si une commande existe
exists() {
  command -v "$1" >/dev/null 2>&1
}

# Vérifie si 'curl' est installé, sinon l'installe avec 'screen'
if exists curl; then
  echo 'curl est déjà installé'
else
  sudo apt update && sudo apt install curl screen -y < "/dev/null"
fi

# Met à jour et met à niveau les paquets du système
sudo apt update && sudo apt upgrade -y

# Installe les paquets nécessaires
sudo apt install screen git curl make bash jq build-essential sed zsh -y

# Version de Go à installer
ver="1.21.1"

# Télécharge et installe Go
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"

# Ajoute Go au PATH
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Vérifie la version de Go installée
go version

# Installe Rust via rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Charge l'environnement Rust
source $HOME/.cargo/env

# Installe cargo-binstall
cargo install cargo-binstall

# Utilise cargo-binstall pour installer cargo-risczero
cargo binstall cargo-risczero

# Clone le dépôt Git de Hyle
git clone https://github.com/Hyle-org/hyle.git
