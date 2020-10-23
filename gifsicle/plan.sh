pkg_name=gifsicle
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_origin=core
pkg_version=1.91
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.lcdf.org/gifsicle/gifsicle-${pkg_version}.tar.gz
pkg_shasum=0a4ee602aa244cdcdd86a250a6b39c94d8343cf526b8fae862d8a0efc337a800
pkg_bin_dirs=(bin)
pkg_deps=(core/zlib core/glibc)
pkg_build_deps=(core/zlib core/coreutils core/diffutils core/patch core/make core/gcc core/sed core/glibc)
pkg_description="Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations."
pkg_upstream_url="https://www.lcdf.org/gifsicle/"
