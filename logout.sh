#!/bin/bash

declare -a logged_in_users=()  
logged_in="logged_in.txt"      

logout_user() {
 echo "=== DELOGARE ==="

 if [ ! -s "$logged_in" ]; then
   echo "Nu există utilizatori autentificați."
   return
  fi

 echo "Utilizatori autentificați:"
 cat "$logged_in"
 echo
 read -p "Introdu numele utilizatorului pentru delogare: " username


 if ! grep -q "^$username$" "$logged_in"; then
  echo "Utilizatorul '$username' nu este autentificat."
 return
 fi
 
sed -i "/^$username$/d" "$logged_in"

for i in "${!logged_in_users[@]}"; do
  if [ "${logged_in_users[$i]}" == "$username" ]; then
  unset 'logged_in_users[i]'
  break
 fi
 done

 echo "Utilizatorul '$username' a fost delogat."
}
