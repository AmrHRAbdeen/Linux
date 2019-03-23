#!/bin/bash
NO_OF_SONGS="100"
#counter= RANDOM % 10
counter=$((1 + RANDOM % NO_OF_SONGS))
echo $counter
