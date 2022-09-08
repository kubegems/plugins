CHARTS_DIR?=plugins
HELM_REPO_USERNAME?=kubegems
HELM_REPO_PASSWORD?=
CHARTMUSEUM_ADDR?=https://${HELM_REPO_USERNAME}:${HELM_REPO_PASSWORD}@charts.kubegems.io/kubegems

install:
# there is a bug on: https://github.com/chartmuseum/helm-push/pull/162 , use fork repository before pr merged temporarily.
	helm plugin install https://github.com/cnfatal/helm-push 

upload:
	@$(foreach file, $(wildcard $(CHARTS_DIR)/*), helm cm-push -d -f $(file) ${CHARTMUSEUM_ADDR};)
