pkg_origin=core
pkg_name=elixir
pkg_version=1.6.5
pkg_description="A dynamic, functional language designed for building scalable and maintainable applications. Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain."
pkg_upstream_url=http://elixir-lang.org
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/elixir-lang/elixir/archive/v${pkg_version}.tar.gz"
pkg_shasum=defe2bed953ee729addf1121db3fa42a618ef1d6c57a1f489da03b0e7a626e89
pkg_deps=(core/busybox core/cacerts core/coreutils core/openssl core/erlang)
pkg_build_deps=(core/busybox core/make)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
    localedef -i en_US -f UTF-8 en_US.UTF-8
    export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
}

do_build() {
    fix_interpreter "rebar" core/coreutils bin/env
    fix_interpreter "rebar3" core/coreutils bin/env
    fix_interpreter "bin/*" core/coreutils bin/env
    make
}
