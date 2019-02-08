#!/bin/bash


# glone a list of repos

READING_FOLDER=$HOME/github/reading

function clone {
    # $1 url
    # $2 name
    if [[ $1 != http* ]]; then
        src="https://github.com/$1"
    else
        src=$1
    fi
    if [ -z $2 ]; then
        dst=${1#*/}
    else
        dst=$2
    fi
    dst=$READING_FOLDER/$dst
    if [[ ! -a $dst ]]; then
        cmd="git clone $src $dst"
        # echo $cmd
        $cmd
    fi
}

function svn-checkout {
    # $1 url
    src=$1
    # $2 name
    if [ -z $2 ]; then
        dst=${1##*/}
    else
        dst=$2
    fi
    dst=$READING_FOLDER/$dst
    if [[ ! -a $dst ]]; then
        cmd="svn checkout $src $dst"
        echo $cmd
        $cmd
    fi
}

# deep learning frameworks
clone FluxML/Flux.jl
clone pytorch/pytorch
clone pytorch/examples pytorch-examples
clone pytorch/text pytorch-text
clone pytorch/tutorials pytorch-tutorials
clone pytorch/vision pytorch-vision
clone tensorflow/tensorflow
clone tensorflow/models tensorflow-models
clone torch/torch7
# clone https://example
clone jupyter/notebook jupyter-notebook
clone wedesoft/aiscm

# AI packages
clone itsrainingdata/sparsebn
svn-checkout svn://svn.r-forge.r-project.org/svnroot/pcalg
