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

| name                                    | example               | desc                                                      |
| --------------------------------------- | --------------------- | --------------------------------------------------------- |
| `plugins.kubegems.io/main-category`     | "kubernetes"          | first level of plugins category                           |
| `plugins.kubegems.io/category`          | "devops"              | plugin category                                           |
| `plugins.kubegems.io/install-namespace` | ""                    | where the plugin should install to by default             |
| `plugins.kubegems.io/use-template`      | "true"                | install this plugin use 'template' engine instead of helm |
| `plugins.kubegems.io/health-check`      | "deployments.apps/\*" | health check targets                                      |
| `plugins.kubegems.io/required`          | "true"                | this plugin is required for init installation             |
