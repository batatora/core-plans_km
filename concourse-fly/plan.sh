pkg_name=concourse-fly
pkg_origin=core
pkg_version="3.11.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Concourse CLI for interacting with the ATC API"
pkg_license=('Apache-2.0')
pkg_upstream_url="https://concourse.ci"

pkg_source="https://github.com/concourse/concourse.git"
pkg_build_deps=("core/cacerts" "core/gnupg" "core/go" "core/git")
pkg_bin_dirs=(bin)

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
  rm -rf "$REPO_PATH"
  git clone --recursive "$pkg_source" "$REPO_PATH"
  pushd "$REPO_PATH" || return 1
    git checkout "tags/v${pkg_version}"
  popd || return 1
}

do_unpack() {
  return 0
}

do_clean() {
  return 0
}

do_verify() {
  return 0
}

do_build(){
  cd "$HAB_CACHE_SRC_PATH/$pkg_dirname/" || return 1
  source .envrc
  cd "$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/concourse/fly" || return 1
  go build
}

do_install(){
  cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/concourse/fly/fly" "${pkg_prefix}/bin/fly"
}
