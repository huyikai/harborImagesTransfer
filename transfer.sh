# 源 Harbor 地址
source="***.**.**.**:****"
# 目标 Harbor 地址
target="***.**.**.**:****"

# 账密
username=******
password=******

# 忽略仓库
ignore=""

# 获取所有项目id
projectIds=$(curl -u $username:$password http://$source/api/projects | jq ".[].project_id")

for projectId in $projectIds; do
    echo project_id:$projectId
    # 获取仓库名-获取到的格式为【项目名/仓库名】
    repositorys=$(
        curl -u $username:$password -G -d 'page=1' -d 'page_size=15' -d project_id=$projectId http://$source/api/repositories | jq ".[].name" -r
    )
    for repository in $repositorys; do
        echo repository:$repository
        # 获取标签
        tags=$(curl -u $username:$password -G -d detail=1 http://$source/api/repositories/$repository/tags | jq ".[].name" -r)
        for tag in $tags; do
            echo Start /$repository:$tag
            # 从源 Harbor 拉镜像
            docker pull $source/$repository:$tag
            # 将源镜像根据目标镜像打 Tag
            docker tag $source/$repository:$tag $target/$repository:$tag
            # 将镜像推送到目标 Harbor
            docker push $target/$repository:$tag
            # 删除镜像
            docker rmi $source/$repository:$tag
            docker rmi $target/$repository:$tag
            echo Complate /$repository:$tag
        done
    done
done
