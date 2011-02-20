
function fail() {
  echo $*
  exit 1
}

function server_pid() {
  ps aux | grep -F -- '-jar lib/winstone-' | grep -v -F 'grep' | awk '{ print $2 }'
}


which lynx > /dev/null || fail "Install lynx"

cd "$(dirname $0)/.."

echo "Building war"
buildr -s clean package || exit 1

echo "Starting server"
script/server.sh > /dev/null &
sleep 2

lynx -dump http://localhost:8080/ | grep -qi 'Hello, World!' && echo "OK!" || echo "Didn't work"

while [ "$(server_pid)" != "" ]; do
  # echo kill $(server_pid)
  kill $(server_pid)
  sleep 1
done
