Golang compile scripts
====

These scripts :

- Cross compile with [gox](https://github.com/mitchellh/gox)
- Package binary as .zip file
- Upload packages to [Github Release](https://developer.github.com/v3/repos/releases/) or [bintray](https://bintray.com/)

## Install

These scripts are supposed to be used in golang project directory.

```bash
$ cd path-to-your-project
$ git clone https://github.com/tcnksm/go-compile-scripts scripts
```

## How to use

Compile:

```bash
$ ./scripts/compile.sh
```

Package binary as .zip file:

```bash
$ ./scripts/package.sh
```

Create release at Github and upload it:

```bash
$ ./scripts/github-create-release.sh
$ ./scripts/github-upload-asset.sh
```

Uploat to bintray:

```bash
$ ./scripts/bintray-upload-asset.sh
```

## Environmetal variables

You need to set belows:

```bash
export VERSION="" 
export GITHUB_TOKEN=""
export BINTRAY_API_KEY=""
export REPO="" # Repository name
```

You can use [direnv](https://github.com/zimbatm/direnv).

## Reference

- [wercker/step-github-create-release](https://github.com/wercker/step-github-create-release)
- [wercker/step-github-upload-asset](https://github.com/wercker/step-github-upload-asset)
- [hashicorp/consul/scripts](https://github.com/hashicorp/consul/blob/master/scripts)

## Author

[tcnksm](https://github.com/tcnksm)


