CHARTS_DIR?=plugins
HELM_REPO_USERNAME?=kubegems
HELM_REPO_PASSWORD?=
CHARTMUSEUM_ADDR?=https://${HELM_REPO_USERNAME}:${HELM_REPO_PASSWORD}@charts.kubegems.io/kubegems


all: package check push
local: package check

generate: helm-schema
	find ${CHARTS_DIR} -mindepth 1 -maxdepth 1 -type d -not -name 'common' | xargs -n1 \
	helm-schema {}

TEMP_CHARTS_DIR := tmp
package:
	find ${CHARTS_DIR} -mindepth 1 -maxdepth 1 -type d | xargs -n1 \
	helm package -u -d ${TEMP_CHARTS_DIR}

check:
	find ${TEMP_CHARTS_DIR}/*.tgz -not -name 'common*' | xargs -n1 \
	helm template -g 1>/dev/null

.PHONY: helm-push
push:
	find ${TEMP_CHARTS_DIR}/*.tgz | xargs -I {} \
	curl --data-binary @{} ${CHARTMUSEUM_ADDR}/api/charts

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

.PHONY: helm-schema
helm-schema:
ifeq (, $(shell which helm-schema))
	go install kubegems.io/kubegems/tools/helm-schema@latest
else
	echo 'helm-schema is already installed'
endif