#!/bin/bash

project_name="speed-checker"
git_url="https://github.com/"
git_user="decrobin"
hub_user="drobinson"


if [[ $# -eq 1 ]]
  then
    branch="$1"
fi

# clone speed-checker, checkout branch in $1, or master otherwise
git clone "${git_url}${git_user}/${project_name}.git" "$project_name"
pushd "$project_name"
if [ ! -z "$branch" ]
    then
    echo "hi"
    git checkout "$branch"
fi
git pull

# build. Can't specify tags in compose so this gets a bit yucky
for image in speed-checker postgres flask
do
    pushd "$image"
    if [ "$image" != "$project_name" ]
        then
        image="speed-checker-${image}"
    fi
    docker build -t "${hub_user}/${image}:${branch}" .
    docker push "${hub_user}/${image}:${branch}"
    popd
done

# clean up, you dirty slob
popd
rm -rf "$project_name"