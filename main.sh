#!/bin/bash

declare -a logged_in_users

while true; do
  clear
  echo "===== MENIU MANAGEMENT UTILIZATORI ====="
  echo "1) Înregistrare utilizator nou"
  echo "2) Autentificare"
  echo "3) Deconectare"
  echo "4) Generare raport utilizator"
  echo "5) Ieșire"
  echo "========================================"
  read -p "Alege o opțiune (1-5): " opt

  case $opt in
    1) bash register.sh ;;
    2) bash login.sh ;;
    3) bash logout.sh ;;
    4) bash report.sh ;;
    5) echo "La revedere!"; exit 0 ;;
    *) echo "Opțiune invalidă!"; sleep 1 ;;
  esac
  read -p "Apasă Enter pentru a continua..."
done
