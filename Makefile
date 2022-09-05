CHARTS_DIR=plugins
CHARTMUSEUM_ADDR=https://charts.kubegems.io/kubegems
HELM_REPO_USERNAME=kubegems
HELM_REPO_PASSWORD=

install:
	helm plugin install https://github.com/chartmuseum/helm-push

upload:
	@$(foreach file, $(wildcard $(CHARTS_DIR)/*), helm cm-push $(file) ${CHARTMUSEUM_ADDR};)
