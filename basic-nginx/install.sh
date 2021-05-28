    2  helm repo add stable https://charts.helm.sh/stable
    3  wget https://github.com/konveyor/pelorus/archive/refs/tags/1.3.0.1.tar.gz
    5  tar -xf 1.3.0.1.tar.gz
    7  cd pelorus-1.3.0.1/
    9  export OCP_API=https://api.cluster-f9d6.dynamic.opentlc.com:6443
   10  oc login --insecure-skip-tls-verify=true ${OCP_API}
   11  oc create namespace pelorus
   12  oc project pelorus
   13  helm install operators charts/operators -n pelorus
   14  oc get po
   15  oc whoami --show-console
   16  helm install pelorus charts/pelorus -n pelorus
   17  oc get po
   18  git clone https://github.com/autstudent/container-pipelines.git
   22  cd container-pipelines/basic-nginx/
   34  yum install ansible -y
   35  ansible-galaxy install -r requirements.yml -p galaxy
   36  vi .applier/group_vars/seed-hosts.yml 
   37  sed -i '/source_code_url:/c\source_code_url: https://github.com/autstudent/container-pipelines.git' .applier/group_vars/seed-hosts.yml
   37  sed -i '/skip_manual_promotion:/c\skip_manual_promotion: true' .applier/group_vars/seed-hosts.yml
   39  ansible-playbook -i ./.applier/ galaxy/openshift-applier/playbooks/openshift-cluster-seed.yml
   40  oc get po
   41  oc get pods -n basic-nginx-build -w
   43  echo -en "\nhttps://$(oc get route prometheus-pelorus -n pelorus -o template --template={{.spec.host}})\n\n"
   44  echo -en "\nhttps://$(oc get route grafana-route -n pelorus -o template --template={{.spec.host}})\n\n"
   70  oc create -f rb.yaml 
   72  sh promote.sh 
   73  oc create secret generic github-secret --from-literal=GIT_USER=autstudent --from-literal=GIT_TOKEN=xxx -n pelorus
   74  cd ../..
   74  mkdir myclusterconfigs
   84  cp pelorus-1.3.0.1/charts/pelorus/values.yaml myclusterconfigs/values.yaml
   86  vi myclusterconfigs/values.yaml
   88  oc project pelorus
   89  helm upgrade pelorus pelorus-1.3.0.1/charts/pelorus --namespace pelorus --values myclusterconfigs/values.yaml
   90  oc get dc/committime-exporter -n pelorus
   91  oc get pods -n pelorus | grep committime
  153  COMMITTIME_EXPORTER_POD=$(oc get pod --selector app=committime-exporter -o jsonpath='{.items[0].metadata.name}' -n pelorus)
  154  oc logs -f ${COMMITTIME_EXPORTER_POD}
  159  oc create secret generic jira-secret --from-literal=SERVER='https://xx.atlassian.net/' --from-literal=USER=xxx@xx.com --from-literal=TOKEN=xx -n pelorus
  161  vi myclusterconfigs/values.yaml 
  163  helm upgrade pelorus pelorus-1.3.0.1/charts/pelorus --namespace pelorus --values myclusterconfigs/values.yaml
  166  FAILURE_EXPORTER_POD=$(oc get pod --selector app=failure-exporter -o jsonpath='{.items[0].metadata.name}' -n pelorus)
  167  oc logs -f ${FAILURE_EXPORTER_POD}
