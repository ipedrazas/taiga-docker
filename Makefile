all: namespace deploy

NAMESPACE?=taiga
NODE_SELECTOR?=pool-jenkins
BASE_DOMAIN?=taiga.example.com
BASE_PROTOCOL?=https

VERSION?=latest
IMAGE_FRONT?=dougg/taiga-front:${VERSION}
IMAGE_BACK?=dougg/taiga-back:${VERSION}

EMAIL_HOST?=
EMAIL_PORT?=
EMAIL_HOST_USER?=
EMAIL_HOST_PASSWORD?=
DEFAULT_FROM_EMAIL?=

destroy:
	#@echo "Destroying namespace ${NAMESPACE} and everything under it"
	#if kubectl get namespace ${NAMESPACE} >/dev/null 2>&1 ; then \
	#  kubectl delete namespace ${NAMESPACE} ; \
	#fi

namespace:
	cat k8s/namespace.yaml | NAMESPACE=${NAMESPACE} envsubst | kubectl apply -f -

deploy:
	cat k8s/postgres.yaml | NODE_SELECTOR=${NODE_SELECTOR} envsubst | kubectl apply --namespace=${NAMESPACE} -f -
	cat k8s/database-setup.yaml | IMAGE_BACK=${IMAGE_BACK} NODE_SELECTOR=${NODE_SELECTOR} envsubst | kubectl apply --namespace=${NAMESPACE} -f -
	cat k8s/taiga.yaml |                         \
	  EMAIL_HOST=${EMAIL_HOST}                   \
	  DEFAULT_FROM_EMAIL=${DEFAULT_FROM_EMAIL}   \
	  EMAIL_PORT=${EMAIL_PORT}                   \
	  EMAIL_HOST_USER=${EMAIL_HOST_USER}         \
	  EMAIL_HOST_PASSWORD=${EMAIL_HOST_PASSWORD} \
	  IMAGE_FRONT=${IMAGE_FRONT}                 \
	  IMAGE_BACK=${IMAGE_BACK} \
	  BASE_DOMAIN=${BASE_DOMAIN} \
	  BASE_PROTOCOL=${BASE_PROTOCOL} \
	  NODE_SELECTOR=${NODE_SELECTOR} envsubst | kubectl apply --namespace=${NAMESPACE} -f -

.PHONY: namespace deploy destroy
