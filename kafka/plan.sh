pkg_name=kafka
pkg_origin=core
pkg_version=0.10.2.1
pkg_source="http://mirrors.gigenet.com/apache/${pkg_name}/${pkg_version}/${pkg_name}_2.11-${pkg_version}.tgz"
pkg_shasum="b86f75c8f078bc818031568155dd442ba6c1ed849663d0a7da9870efc96be461"
pkg_dirname="${pkg_name}_2.11-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_upstream_url="https://kafka.apache.org/"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/bash-static
  core/coreutils
  core/jre8
)
pkg_binds=(
  [zookeeper]="port"
)

do_build() {
  fix_interpreter "./bin/*" core/bash-static bin/bash
}

do_install() {
  cp -R libs bin "${pkg_prefix}"
}
