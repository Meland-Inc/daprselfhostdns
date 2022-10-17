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
readonly consulAddress=${ip:-"192.168.50.171"}
RUN_ROOT="$PROJECT_ROOT"
cd $PROJECT_ROOT;

fullConsulAddress="$consulAddress:8500"
# echo "请输入dns地址";
# read -r consulAddress
# consulAddress="$consulAddress"

echo "当前使用dns url: ${fullConsulAddress}";
 
cat "$PROJECT_ROOT/config/consul.yaml" | sed "s/\$consulAddress/$fullConsulAddress/g" > ~/.dapr/components/consul.yaml;

cat "$PROJECT_ROOT/config/config.yaml" | sed "s/\$consulAddress/$fullConsulAddress/g" > ~/.dapr/config.yaml;

cat "$PROJECT_ROOT/config/pubsub.yaml" | sed "s/\$localhost/$consulAddress/g" > ~/.dapr/components/pubsub.yaml;