pkg_name=boringssl
pkg_origin=core
pkg_description="BoringSSL is a fork of OpenSSL that is designed to meet Google\'s needs."
pkg_upstream_url='https://boringssl.googlesource.com/boringssl/'
pkg_version=3538
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('OpenSSL ISC')
pkg_source="https://boringssl.googlesource.com/boringssl/+archive/${pkg_version}.tar.gz"
pkg_shasum="None"
pkg_deps=(
  core/glibc
  core/go
  core/cmake
  core/ninja
  core/perl
  core/gcc
)
pkg_build_deps=(
  core/glibc
  core/gcc-libs
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)


# This feels bad but Google doesn't do releases and that branch is a moving target
do_verify() {
  return 0
}

do_build() {
  pushd .. >/dev/null
  mkdir -p "build"
  pushd build >/dev/null
  cmake -GNinja ..
  ninja
  popd >/dev/null
  pushd .. >/dev/null

}

do_install() {
  pushd ../build >/dev/null
  mkdir -p "${pkg_prefix}/bin" "${pkg_prefix}/include" "${pkg_prefix}/lib"
  mv tool/bssl "${pkg_prefix}/bin"
  mv ssl/libssl.a           "${pkg_prefix}/lib"
  mv crypto/libcrypto.a     "${pkg_prefix}/lib"
  mv decrepit/libdecrepit.a "${pkg_prefix}/lib"
  mv ../include/openssl "${pkg_prefix}/include"
  popd >/dev/null
}
