CHARTS_DIR?=plugins
HELM_REPO_USERNAME?=kubegems
HELM_REPO_PASSWORD?=
CHARTMUSEUM_ADDR?=https://${HELM_REPO_USERNAME}:${HELM_REPO_PASSWORD}@charts.kubegems.io/kubegems

generate:
	@$(foreach dir, $(wildcard $(CHARTS_DIR)/*), \
	readme-generator -v $(dir)/values.yaml -r $(dir)/README.md -m $(dir)/values.schema.json \
	;)

TEMP_CHARTS_DIR := tmp
package:
	$(foreach dir, $(wildcard $(CHARTS_DIR)/*/), \
	helm package -u -d ${TEMP_CHARTS_DIR} $(dir) \
	;)

.PHONY: helm-push
push:
	$(foreach file, $(wildcard $(TEMP_CHARTS_DIR)/*.tgz), \
	curl --data-binary "@$(file)" ${CHARTMUSEUM_ADDR}/api/charts \
	;)

.PHONY: readme-generator
readme-generator:
ifeq (, $(shell which readme-generator))
	@{ \
	set -e ;\
	echo 'installing readme-generator-for-helm' ;\
	npm install -g readme-generator-for-helm ;\
	}
else
	echo 'readme-generator-for-helm is already installed'
endif