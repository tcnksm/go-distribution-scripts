Scripts for distributing golang project [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/tcnksm/go-distribution-scripts/blob/master/LICENCE)
====

This is my small scripts for distributing golang projects. They will:

- Cross compile with [mitchell/gox](https://github.com/mitchellh/gox)
- Package binary as .zip file

## Install

These scripts are supposed to be used in golang project directory.

```bash
$ cd path-to-your-project
$ git clone https://github.com/tcnksm/go-distribution-scripts scripts
```

## Usage

Set version:

```bash
$ export VERSION="" 
```

Compile:

```bash
$ ./scripts/compile.sh
```

Package binary as .zip file:

```bash
$ ./scripts/package.sh
```

## Author

[tcnksm](https://github.com/tcnksm)


