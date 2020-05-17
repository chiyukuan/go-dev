# Readme

## Note

- devel_node: k8s node with devel-src=golang label
## Procedure

- copy the kube/config file from k8s to local
- do ssh-copy-id to k8s nodes
- copy id_rsa_pw id_rsa_pw.pud to .ssh@devel_node

- sdwan-operator
  ```
  wget 'https://coreupdate.central.arubanetworks.com/packages/sdwan-operator.1.0.0-235.tar'
  tar xvf sdwan-operator.1.0.0-235.tar
  upgrades_off
  ./sdwan-operator/src/ft/presetup.sh
  
  kubectl create -f sdwan-crd.yaml
  kubectl create -f sdwan-operator.yaml
  
  kubectl -n acp-system exec -it `kubectl -n acp-system get pods -l=name=sdwan-operator --no-headers | cut -d" " -f1` -- python /opt/aruba/scripts/generate_playbooks.py --gen-cr
  ## Then copy and paste the generated yaml to "sdwan-production-cr.yaml" on your local CL
  kubectl create -f sdwan-production-cr.yaml
  
  kubectl apply -f sdwan-production-cr.yaml
  
  ```
  
