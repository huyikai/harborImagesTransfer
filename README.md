# Harbor 镜像迁移脚本

业务中，Harbor 转移至 kubesphere。使用了 kubesphere 内置应用构建了 harbor。

因前后版本差异过大。没法通过 volume 的方式转移数据。

因 harbor 由 docker compose 构建，配置繁多易出错留下隐患，考虑到需要保证迁移后的稳定性，最终商定，将原 harbor 镜像拉至本地，上传到新 harbor 上来解决此次迁移问题。

为提高迁移效率，故编写了此脚本。

## Usage

1. 修改脚本中  源、目标、登录 harbor 的账密。

   ```sh
   # 源 Harbor 地址
   source="***.**.**.**:****"
   # 目标 Harbor 地址
   target="***.**.**.**:****"
   # 账密
   username=******
   password=******
   ```

2. 确认脚本中请求项目、仓库、标签的 URL 是否正确，**因为不同版本的 Harbor 请求地址会有所不同**。
   可以去源 Harbor WEB 页面中打开开发调试工具中的 Network 对比一下，请注意甄别并及时修改。
   修改时注意 CURL 、jq 的使用，下面简单说明一下使用到的 Option。

   ```shell
   # CURL
   -u 账密 例：admin:admin123
   -G get请求
   -d 传参 例：-d id=123
   # jq
   .[] 解析所有数组项
   .name 解析数据中key为"name"项
   -r 去除数据中双引号
   ```

   


