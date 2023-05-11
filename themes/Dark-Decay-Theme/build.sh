#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package Dark-Decay-Theme

git clone https://github.com/decaycs/decay-gtk

pushd decay-gtk
  mkdir -pv /usr/share/themes
  cp -rvf ./Themes/Dark-decay /usr/share/themes
popd

rm -rf ./decay-gtk
