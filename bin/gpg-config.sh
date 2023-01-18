#!/usr/bin/env bash

KEYS_LIST=$(gpg --list-secret-keys --keyid-format LONG | egrep -o "[A-F0-9]{40}")
EMAILS_LIST=$(gpg --list-secret-keys --keyid-format LONG | egrep -o "<.*@.*>" | sed "s/[<>]//g")

KEYS=($(echo $KEYS_LIST | tr ' ' "\n"))
EMAILS=($(echo $EMAILS_LIST | tr ' ' "\n"))

echo "List of emails and GPG's"

INDEX=0

for KEY in ${KEYS[@]}
do
    EMAIL=${EMAILS[$INDEX]}

    echo ".............................."
    echo $"Email: $EMAIL"
    echo $"GPG: $KEY"
    echo ".............................."
    echo ""

    ((INDEX=$INDEX+1))
done

read -p "Enter your gpg key id: " GPG_KEY_ID
read -p "Enter your git email: " GIT_EMAIL
read -p "Enter your git username: " GIT_USERNAME

git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git config user.signingkey "$GPG_KEY_ID"
git config commit.gpgsign true

echo $GIT_USERNAME $GIT_EMAIL $GPG_KEY_ID "configured"
