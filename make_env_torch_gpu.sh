#!/bin/sh
#
# Install PyTorch on Mac both Intel and Arm 64
#
# Author   : Carl van Heezik
# Revision : 1.0
# Date     : 2023-03-18

# Prerequisites python3, pip3 
if ! command -v python3
then
  # Install commandline tools on Mac
  xcode-select --install
fi

# Upgrade pip3 to latest version 
pip3 install --upgrade pip

# Prerequisites homebrew
if ! command -v brew
then
  echo "brew not found, install brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  brew upgrade 
fi

# Prerequisites visual studio code  
if ! command -v code
then
  echo "vscode not found, install vscode"
  brew install --cask visual-studio-code
fi 

# Prerequisites anaconda for using Python environments 
if ! command -v conda
then
  echo "conda not found, install miniconda"
  brew install --cask miniconda
  conda init "$(basename "${SHELL}")"
  conda config --set auto_activate_base false
fi 

export CONDA_ALWAYS_YES="true"

# Create new conda environment
env_name=torch_gpu
conda create -n $env_name python=3.9.6
# Activate conda environment
conda activate $env_name

# Install numpy and pytorch 
conda install -n $env_name -c pytorch pytorch torchvision torchaudio 

# Install jupyter notebook 
conda install -n $env_name -c anaconda jupyter  
conda install -n $env_name -c anaconda ipykernel -c anaconda 
conda install -n $env_name -c anaconda ipywidgets 

unset CONDA_ALWAYS_YES