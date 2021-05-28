oc start-build basic-nginx -w -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-dev -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-stage -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-prod -n basic-nginx-build
