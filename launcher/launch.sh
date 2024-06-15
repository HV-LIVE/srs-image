#!/bin/sh
set -o errexit

work_dir="$(dirname $(readlink -f $0))"
cd "$work_dir"

echo "setup config"
python3 "$work_dir/setup.py"

# 回到原镜像设定的工作目录
cd "/usr/local/srs"

echo "launch srs"
exec "/usr/local/srs/objs/srs" "-c" "/usr/local/srs/conf/custom.conf"
