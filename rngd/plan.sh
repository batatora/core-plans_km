pkg_name=rngd
pkg_derivation=chef
pkg_version=5
pkg_license=('gplv2')
pkg_maintainer="The Bldr Maintainers <bldr@chef.io>"
pkg_source=http://downloads.sourceforge.net/sourceforge/gkernel/rng-tools-${pkg_version}.tar.gz
pkg_shasum=60a102b6603bbcce2da341470cad42eeaa9564a16b4490e7867026ca11a3078e
pkg_gpg_key=3853DA6B
pkg_binary_path=(bin sbin)
pkg_build_deps=(chef/gcc chef/make)
pkg_deps=(chef/glibc)
pkg_dirname=rng-tools-5
pkg_service_run="sbin/rngd -f -r /dev/urandom"
pkg_service_user=root
