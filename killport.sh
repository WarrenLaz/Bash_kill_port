
killport() {
  port=$1

  if [ -z "$port" ]; then
    echo "Usage: killport <port>"
    return 1
  fi

  processes=$(lsof -t -i :$port)

  if [ -z "$processes" ]; then
    echo "No process found using port $port"
    return
  fi

  echo "Processes using port $port:"
  lsof -i :$port

  echo -n "Kill these processes? (y/n): "
  read confirm

  if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "$processes" | xargs kill -9
    echo "Killed processes on port $port"
  else
    echo "Cancelled."
  fi
}
