pkg_name=dotnet-core
pkg_origin=core
pkg_version=2.2.0
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://download.visualstudio.microsoft.com/download/pr/1057e14e-16cc-410b-80a4-5c2420c8359c/004dc3ce8255475d4723de9a011ac513/dotnet-runtime-${pkg_version}-linux-x64.tar.gz"
pkg_shasum=452ea9e2fc4f84fd5d0bf17501aa99a99d33badabee23950e537a1a4dc6a2b05
pkg_filename="dotnet-debian-x64.${pkg_version}.tar.gz"
pkg_deps=(
  core/curl
  core/gcc-libs
  core/glibc
  core/icu52
  core/krb5
  core/libunwind
  core/lttng-ust
  core/openssl
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/patchelf
)
pkg_bin_dirs=(bin)

do_unpack() {
  # Extract into $pkg_dirname instead of straight into $HAB_CACHE_SRC_PATH.
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" \
    -C "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" \
    --no-same-owner
}

do_prepare() {
  find . -type f -name 'dotnet' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;
  find . -type f -name '*.so*' \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

do_build() {
  return 0
}

do_install() {
  cp -a . "${pkg_prefix}/bin"
  chmod o+r -R "${pkg_prefix}/bin"
  # Move text files out of bin directory
  mv "${pkg_prefix}/bin/LICENSE.txt" "${pkg_prefix}/LICENSE.txt"
  mv "${pkg_prefix}/bin/ThirdPartyNotices.txt" "${pkg_prefix}/ThirdPartyNotices.txt"
}

do_strip() {
  return 0
}
