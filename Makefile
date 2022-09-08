CHARTS_DIR?=plugins
HELM_REPO_USERNAME?=kubegems
HELM_REPO_PASSWORD?=
CHARTMUSEUM_ADDR?=https://${HELM_REPO_USERNAME}:${HELM_REPO_PASSWORD}@charts.kubegems.io/kubegems

install:
	helm plugin install https://github.com/chartmuseum/helm-push

upload:
	@$(foreach file, $(wildcard $(CHARTS_DIR)/*), helm cm-push -d -f $(file) ${CHARTMUSEUM_ADDR};)
