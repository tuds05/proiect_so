#!/bin/bash

REGISTRU="users.csv"

echo "=== AUTENTIFICARE ==="
read -p "Nume utilizator: " username

# Verificare dacă utilizatorul există
line=$(grep ",$username," "$REGISTRU")
if [[ -z "$line" ]]; then
  echo "Utilizator inexistent!"
  exit 1
fi

read -s -p "Parolă: " password
echo
hash=$(echo -n "$password" | sha256sum | cut -d ' ' -f1)

# Extragem parola hash din registru
saved_hash=$(echo "$line" | cut -d ',' -f4)

if [[ "$hash" == "$saved_hash" ]]; then
  home_dir=$(echo "$line" | cut -d ',' -f5)
  last_login=$(date "+%Y-%m-%d %H:%M:%S")

  # Actualizare last_login cu sed
  escaped_old=$(echo "$line" | sed 's/[^^]/[&]/g; s/\^/\\^/g')
  updated_line=$(echo "$line" | sed "s/[^,]*\$/$last_login/")
  sed -i "s|$escaped_old|$updated_line|" "$REGISTRU"

  # Navigăm în home-ul utilizatorului
  cd "$home_dir" || exit
  echo "Autentificare reușită. Ai fost direcționat în $home_dir"
else
  echo "Parolă incorectă!"
  exit 1
fi

