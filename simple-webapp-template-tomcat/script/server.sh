
project_root="$(dirname $0)/.."
export CATALINA_HOME=${CATALINA_HOME:-$project_root/../apache-tomcat-6.0.32}
export CATALINA_BASE="$project_root/tomcat-stuff"

"$CATALINA_HOME/bin/catalina.sh" run


