
project_root="$(dirname $0)/.."

function fail() {
  echo $*
  exit 1
}

which lynx > /dev/null || fail "Install lynx"

cd "$project_root"


echo "Building war"
ant -q clean war || exit 1

echo "Starting server"
script/server.sh start
trap "$project_root/script/shutdown.sh > /dev/null" EXIT 

sleep 2

lynx -dump http://localhost:8080/ | grep -qi 'Hello, World!' && echo "OK!" || fail "Didn't work"

