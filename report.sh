#!/bin/bash

echo "=== RAPORT UTILIZATOR ==="
read -p "Nume utilizator: " username

line=$(grep ",$username," users.csv)
if [[ -z "$line" ]]; then
  echo "Utilizator inexistent!"
  exit 1
fi

home_dir=$(echo "$line" | cut -d ',' -f5)
raport="$home_dir/raport.txt"

(
  num_fisiere=$(find "$home_dir" -type f | wc -l)
  num_directoare=$(find "$home_dir" -type d | wc -l)
  marime=$(du -sh "$home_dir" | cut -f1)

  echo "Raport utilizator: $username" > "$raport"
  echo "Număr fișiere: $num_fisiere" >> "$raport"
  echo "Număr directoare: $num_directoare" >> "$raport"
  echo "Dimensiune totală: $marime" >> "$raport"
) &

echo "Raportul este generat asincron și va fi salvat în: $raport"
