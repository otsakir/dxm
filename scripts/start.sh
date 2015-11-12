DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
nginx -p $DIR/../app/nginx -c conf/nginx.conf
