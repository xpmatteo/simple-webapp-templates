
function fail() {
  echo $*
  exit 1
}

function server_pid() {
  ps aux | grep -F -- '-jar lib/winstone-' | grep -v -F 'grep' | awk '{ print $2 }'
}

function shutdown() {
  while [ "$(server_pid)" != "" ]; do
    # echo kill $(server_pid)
    kill $(server_pid)
    sleep 1
  done  
}


which lynx > /dev/null || fail "Install lynx"

cd "$(dirname $0)/.."

echo "Building war"
ant war || exit 1

echo "Starting server"
script/server.sh > /dev/null &
trap shutdown EXIT
sleep 2

lynx -dump http://localhost:8080/ | grep -qi 'Hello, World!' && echo "OK!" || fail "Didn't work"

