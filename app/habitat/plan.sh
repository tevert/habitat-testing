pkg_origin=centare
pkg_name=helloworld
pkg_version=0.0.1
pkg_maintainer="Tyler Evert <tyler.evert@centare.com>"
pkg_license=(https://spdx.org/licenses/MIT.html)
pkg_source=nosuch.tar.gz
pkg_deps=(core/jdk8 core/tomcat8)
pkg_build_deps=(core/maven)
pkg_svc_user="root"
pkg_svc_run="tomcat/bin/catalina.sh run"

do_build() {
  echo "Building!"
  pushd $PLAN_CONTEXT/..
  export JAVA_HOME=$(pkg_path_for jdk8)
  mvn install
  popd

  return 0
}

do_install() {
  echo "Installing!"
  pushd $pkg_prefix
  mkdir lib
  mkdir config
  cp -a $PLAN_CONTEXT/../target/*.war lib
  cp -a $PLAN_CONTEXT/../config/* config
  cp -a $PLAN_CONTEXT/../default.toml .
  popd

  return 0
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
