#!/bin/bash

REGISTRU="users.csv"
mkdir -p home

echo "=== ÎNREGISTRARE ==="
read -p "Nume utilizator: " username

# Verificare dacă utilizatorul deja există
if grep -q ",$username," "$REGISTRU" 2>/dev/null; then
  echo "Utilizatorul '$username' există deja."
  exit 1
fi

read -p "Email: " email
read -s -p "Parolă: " password
echo

# Validare email
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$ ]]; then
  echo "Email invalid."
  exit 1
fi

# Hash parolă
hash=$(echo -n "$password" | sha256sum | cut -d ' ' -f1)

# ID unic
id=$(date +%s)

# Director home
home_dir="home/$username"
mkdir -p "$home_dir"

# Adăugare în registru CSV
echo "$id,$username,$email,$hash,$home_dir,N/A" >> "$REGISTRU"

# Simulare trimitere email
echo "Contul tău a fost creat cu succes!" | sendmail "$email" 2>/dev/null

echo "Utilizatorul '$username' a fost înregistrat cu succes."

