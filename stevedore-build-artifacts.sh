#!/bin/sh

version_string="$1"
artifact_path='producedbuilds/*'

if [ ! "$version_string" ]; then
    echo "missing arg: version_string"
    exit 1
fi

sudo chmod -v +x Artifacts/Builds/Binaries/Linux/csc
ls -l Artifacts/Builds/Binaries/Linux/csc
sudo chmod -v +x Artifacts/Builds/Binaries/Linux/VBCSCompiler
ls -l Artifacts/Builds/Binaries/Linux/VBCSCompiler

sudo chmod -v +x Artifacts/Builds/Binaries/Mac/csc
ls -l Artifacts/Builds/Binaries/Mac/csc
sudo chmod -v +x Artifacts/Builds/Binaries/Mac/VBCSCompiler
ls -l Artifacts/Builds/Binaries/Mac/VBCSCompiler

mkdir -p producedbuilds

7z a producedbuilds/roslyn-csc-linux.7z $PWD/Artifacts/Builds/Binaries/Linux/*
7z a producedbuilds/roslyn-csc-mac.7z $PWD/Artifacts/Builds/Binaries/Mac/*
7z a producedbuilds/roslyn-csc-win64.7z $PWD/Artifacts/Builds/Binaries/Windows/*
7z a producedbuilds/roslyn-csc-net46.7z $PWD/Artifacts/Builds/Binaries/Net46/*

for path in $artifact_path;do
  artifact_hash="$(sha256sum "$path" | cut -f1 -d ' ')"
  source_artifact_id="$(basename "$PWD/$path" .7z)/${version_string}_${artifact_hash}.7z"

  echo "source artifact id: $source_artifact_id"
done
