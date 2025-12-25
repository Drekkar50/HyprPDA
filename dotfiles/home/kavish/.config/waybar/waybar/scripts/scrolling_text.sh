#!/bin/bash

text="All primary systems online....    "
while true; do
    echo "${text:0:26}"  # show first 30 characters
    text="${text:1}${text:0:1}"  # rotate left
    sleep 0.5
done


