pkg_origin=centare
pkg_name=helloworld
pkg_version=0.0.1
pkg_maintainer="Tyler Evert <tyler.evert@centare.com>"
pkg_license=(https://spdx.org/licenses/MIT.html)
pkg_source=https://github.com/tevert/habitat-testing.git
pkg_shasum=2c189cbbfea0feda1781b411e5a3add6ccbabce5f8e020c0dfd77c7e95a3baa0
pkg_deps=(core/jdk8)
pkg_build_deps=(core/git core/cacerts)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="$(pkg_path_for jdk8)/bin/java Main.class"

do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  git clone https://github.com/tevert/habitat-testing.git .
  git checkout $pkg_version
  tar -cjvf $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.tar.bz2 \
      --transform "s,^\./habitat-testing,habitat-testing${pkg_version}," . \
      --exclude .git --exclude .gitignore
  pkg_shasum=$(trim $(sha256sum $HAB_CACHE_SRC_PATH/${pkg_filename} | cut -d " " -f 1))
}

do_build() {
  $(pkg_path_for jdk8)/bin/javac *.java
  mkdir bin
  mv *.class bin
}
