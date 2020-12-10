pkg_name=cppcheck
pkg_origin=core
pkg_version=1.84
pkg_description="static analysis of C/C++ code"
pkg_upstream_url="http://cppcheck.sourceforget.net"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_source="https://github.com/danmar/cppcheck/archive/${pkg_version}.tar.gz"
pkg_filename="${pkg_version}.tar.gz"
pkg_shasum=aaa6293d91505fc6caa6982ca3cd2d949fa1aac603cabad072b705fdda017fc5
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/pcre
)
pkg_build_deps=(
  core/pkg-config
  core/cmake
  core/ninja
  core/gcc
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  export BUILDDIR="_build"
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
}

do_build() {
  _PCRE_PATH="$(pkg_path_for pcre)"

  pushd "${BUILDDIR}" || exit 1
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DBUILD_TESTS="${DO_CHECK}" \
    -DHAVE_RULES="yes" \
    -DPCRE="${_PCRE_PATH}/lib" \
    -G Ninja \
    ..
  ninja
  popd || exit 1
}

do_check() {
  pushd "${BUILDDIR}" || exit 1
  ctest -V
  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  ninja install
  popd || exit 1
}
