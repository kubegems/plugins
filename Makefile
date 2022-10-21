CHARTS_DIR?=plugins
HELM_REPO_USERNAME?=kubegems
HELM_REPO_PASSWORD?=
CHARTMUSEUM_ADDR?=https://${HELM_REPO_USERNAME}:${HELM_REPO_PASSWORD}@charts.kubegems.io/kubegems


all: package check push

generate:
	find ${CHARTS_DIR} -mindepth 1 -maxdepth 1 -type d -exec \
	readme-generator -v {}/values.yaml -r {}/README.md -m {}/values.schema.json \;

TEMP_CHARTS_DIR := tmp
package:
	find ${CHARTS_DIR} -mindepth 1 -maxdepth 1 -type d -exec helm package -u -d ${TEMP_CHARTS_DIR} {} +

check:
	find ${TEMP_CHARTS_DIR}/*.tgz -not -name 'common*' -exec helm template -g {} \; 1>/dev/null

.PHONY: helm-push
push:
	find ${TEMP_CHARTS_DIR}/*.tgz -exec curl --data-binary "@{}" ${CHARTMUSEUM_ADDR}/api/charts \;

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