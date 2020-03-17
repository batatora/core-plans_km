pkg_name=ncurses
pkg_derivation=chef
pkg_version=6.0
pkg_license=('ncurses')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260
pkg_deps=(chef/glibc chef/gcc-libs)
pkg_build_deps=(chef/binutils chef/gcc)
pkg_binary_path=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_gpg_key=3853DA6B

do_build() {
  ./configure --prefix=$pkg_prefix \
    --with-shared \
    --with-termlib \
    --with-cxx-binding \
    --with-cxx-shared \
    --without-ada \
    --enable-sigwinch \
    --enable-pc-files \
    --enable-symlinks \
    --enable-widec \
    --enable-ext-colors \
    --without-debug \
    --with-normal \
    --enable-overwrite \
    --disable-rpath-hack
  make
}

do_install() {
  make install

  # Many packages that use Ncurses will compile just fine against the widechar
  # libraries, but won't know to look for them. Create linker scripts and
  # symbolic links to allow older and non-widec compatible programs to build
  # properly
  #
  # Thanks to: http://clfs.org/view/sysvinit/x86_64-64/final-system/ncurses.html
  local maj=$(echo $pkg_version | cut -d "." -f 1)
  local maj_min=$(echo $pkg_version | cut -d "." -f 1-2)
  for x in curses ncurses form panel menu tinfo; do
    echo "INPUT(-l${x}w)" > $pkg_path/lib/lib${x}.so
    ln -sv lib${x}w.so $pkg_path/lib/lib${x}.so.$maj
    ln -sv lib${x}w.so $pkg_path/lib/lib${x}.so.$maj_min
  done
  ln -sfv libncursesw.so $pkg_path/lib/libcursesw.so
  ln -sfv libncursesw.a $pkg_path/lib/libcursesw.a
  ln -sfv libncursesw.a $pkg_path/lib/libcurses.a

  # Install the license, which comes from the README
  install -dv $pkg_path/share/licenses
  grep -B 100 '$Id' README > $pkg_path/share/licenses/LICENSE
}
