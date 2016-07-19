pkg_origin=centare
pkg_name=helloworld
pkg_version=0.0.1
pkg_maintainer="Tyler Evert <tyler.evert@centare.com>"
pkg_license=(https://spdx.org/licenses/MIT.html)
pkg_source=nosuch.tar.gz
pkg_deps=(core/jdk8)
pkg_build_deps=()
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="bin/runService"

do_build() {
  echo "Compling Java code Main.java in $(pwd)"
  #$(pkg_path_for jdk8)/bin/javac $PLAN_CONTEXT/../Main.java
  javac $PLAN_CONTEXT/../Main.java
}

do_install() {
  mkdir -p $pkg_prefix/bin
  mv $PLAN_CONTEXT/../*.class $pkg_prefix/bin
  cat <<EOT >> $pkg_prefix/bin/runService
#!/bin/sh
cd $pkg_prefix/bin
exec java Main 2>&1
EOT
  chmod +x $pkg_prefix/bin/runService
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}
