# plugins

This repo holds all plugins of kubegems plugin system.

## Plugin Develop

Follow [DEVELOP.md](DEVELOP.md) to create a new plugin.

## Plugin Annotations

Annotations used by kubegems plugin system in `Chart.yaml` `.annotations` field:

| name                                    | example                          | desc                                                                 |
| --------------------------------------- | -------------------------------- | -------------------------------------------------------------------- |
| `plugins.kubegems.io/is-plugin`         | (required) "true"                | mark this chart is a kubegems plugin                                 |
| `plugins.kubegems.io/install-namespace` | (required) "kubegems-installer"  | plugin install namespace                                             |
| `plugins.kubegems.io/category`          | (required) "core/devops"         | 'core' is top category, 'devops' is category                         |
| `plugins.kubegems.io/values-from`       | (optional) "logging,tracing"     | use values from other plugins                                        |
| `plugins.kubegems.io/required`          | (optional) "true"                | this plugin is required for init installation and can't be uninstall |
| `plugins.kubegems.io/health-check`      | (optional) "deployments.apps/\*" | health check targets                                                 |

## Plugin Schema Generate

```sh
make generate
```

Use [kubegems/tools/helm-schema](https://github.com/kubegems/kubegems/blob/main/tools/helm-schema) to generate all schema defination from `values.yaml` file.
