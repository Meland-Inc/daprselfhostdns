set -o errexit
set -o nounset
set -o pipefail

### get project dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
readonly PROJECT_ROOT="$(dirname $DIR)"
RUN_ROOT="$PROJECT_ROOT"
cd $PROJECT_ROOT;

consulAddress=""
echo "请输入dns地址";
read -r consulAddress

consulAddress="$consulAddress"

cat "$PROJECT_ROOT/config/consul.yaml" | sed "s/\$consulAddress/$consulAddress/g" > ~/.dapr/components/consul.yaml;

cat "$PROJECT_ROOT/config/config.yaml" | sed "s/\$consulAddress/$consulAddress/g" > ~/.dapr/config.yaml;