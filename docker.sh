# 原harbor
from="172.20.1.42:8580"
# 目标harbor
to="172.20.1.61:31904"

# 项目名
project="fireinvestigation"
# 仓库名
repository="fireinvestigation-modules-mediapush"
# 标签数组
tags="SNAPSHOT-19 20220512-1250 SNAPSHOT-20 SNAPSHOT-22 SNAPSHOT-12 SNAPSHOT-21 20220513a 20220517-1053 20220512-1624 SNAPSHOT-13 SNAPSHOT-17 SNAPSHOT-14 SNAPSHOT-16 20220525-0901"
# 标签前缀
prefix=""

echo Start Transfer

for tag in $tags; do
    docker pull $from/$project/$repository:$prefix$tag
    docker tag $from/$project/$repository:$prefix$tag $to/$project/$repository:$prefix$tag
    docker push $to/$project/$repository:$prefix$tag
    docker rmi $from/$project/$repository:$prefix$tag
    docker rmi $to/$project/$repository:$prefix$tag

    echo /$project/$repository:$prefix$tag Complate
done

echo All Complate
