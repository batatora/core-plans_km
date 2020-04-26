pkg_name=guile
pkg_origin=core
pkg_version=2.0.12
pkg_description="An implementation of the Scheme programming language, used in many GNU programs as an extension language."
pkg_upstream_url="https://www.gnu.org/software/guile/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/pub/gnu/guile/guile-${pkg_version}.tar.xz"
pkg_shasum=de8187736f9b260f2fa776ed39b52cb74dd389ccf7039c042f0606270196b7e9
pkg_deps=(core/glibc
          core/gcc-libs
          core/libtool
          core/gmp
          core/libunistring
          core/libffi
          core/bdwgc
          core/readline
          core/libatomic_ops)
pkg_build_deps=(core/gcc core/make core/diffutils core/pkg-config)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  PKG_CONFIG_PATH="$(pkg_path_for libffi)/lib/pkgconfig"
  PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(pkg_path_for bdwgc)/lib/pkgconfig"
  LDFLAGS="-lgcc_s ${LDFLAGS}"
  export PKG_CONFIG_PATH
  export LDFLAGS
}

do_check() {
  make check
}
