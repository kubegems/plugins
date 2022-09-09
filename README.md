# plugins

plugin, is a plugin syste,m of kubegems.It provides plugable extension functions for kubegems.

Plugins extend from helm charts.

## Features

- 由于部分插件仅需要运行在主集群，需要增加插件应用范围,设置插件仅能在主集群启用。
- 插件之间可能有依赖关系，并可能配置联动，需要增加插件之间的依赖设置和参数共享。
- 插件能给被更新，所以插件需要有版本。
- 插件能给被远程更新，需要有插件源。插件源可以设置为 http 以及本地文件路径。

## Define a plugin

add custom annotations to Chart.yaml annotations field:

| name                                    | example                          | desc                                          |
| --------------------------------------- | -------------------------------- | --------------------------------------------- |
| `plugins.kubegems.io/is-plugin`         | (required) "true"                | mark this chart is a kubegems plugin          |
| `plugins.kubegems.io/install-namespace` | (required) "kubegems-installer"  | plugin install namespace                      |
| `plugins.kubegems.io/category`          | (required) "core/devops"         | 'core' is top category, 'devops' is category  |
| `plugins.kubegems.io/values-from`       | (optional) "logging,tracing"     | use values from other plugins                 |
| `plugins.kubegems.io/health-check`      | (optional) "deployments.apps/\*" | health check targets                          |
| `plugins.kubegems.io/required`          | (optional) "true"                | this plugin is required for init installation |
