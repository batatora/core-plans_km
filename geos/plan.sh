pkg_name=geos
pkg_origin=core
pkg_version=3.6.2
pkg_description="GEOS (Geometry Engine - Open Source) is a C++ port of the ​Java Topology Suite (JTS)."
pkg_upstream_url=http://trac.osgeo.org/geos
pkg_license=('LGPL')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/geos/geos-${pkg_version}.tar.bz2
pkg_shasum=045a13df84d605a866602f6020fc6cbf8bf4c42fb50de237a08926e1d7d7652a
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_deps=(
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
