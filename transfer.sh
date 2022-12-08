# 原harbor
from="***.**.**.**:****"
# 目标harbor
to="***.**.**.**:****"

# 项目名
project="projectName"
# 仓库名
repository="repositoryName"
# 标签数组
tags="tag1 tag2 tag3"
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
