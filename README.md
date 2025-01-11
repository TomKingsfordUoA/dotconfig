# dotconfig

The intention of this repository is to capture my development environment configuration in a manner amendable to deployment in an offline environment.

To that end, it includes a copy of .local/share so that plugins can be deployed without internet access.

This primarily surrounds neovim config.

A dockerfile is included to define a standard installation and to allow offline tests

## TODO

* [ ] Create a refresh plugins script
  * nb pince plugins are stored in `.local/share` and it's abnormal to save this (the package manager can just load this if there is an internet connection).
  * I want to be able to drop this and refresh it from the package manager, then store this refreshed version in my dotconfig repo.
  * The script should, in an internet-attached docker container
    1. Drop `local/share`
    1. Start nvim and get lazy.nvim/mason to pull package.
    1. Drop the git repos (for size and so that I don't check in submodules): `cd .local/share && rm -rf $(find . -name .git)`
    1. Write this back out to dotconfig and create a new commit.
