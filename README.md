# Harbor 镜像迁移脚本

业务中，harbor 转移至 kubesphere。使用了 kubesphere 内置应用构建了 harbor。

因前后版本差异过大。没法通过 volume 的方式转移数据。

因 harbor 由 docker compose 构建，配置繁多易出错留下隐患，考虑到需要保证迁移后的稳定性，最终商定，将原 harbor 镜像拉至本地，上传到新 harbor 上来解决此次迁移问题。