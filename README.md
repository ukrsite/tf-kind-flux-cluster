# tf-kind-flux-cluster
## Bootstrap with GitHub
Install Flux into a Kubernetes cluster and configure it to synchronize from a GitHub repository. Begin with creating a GitHub repository, in this case it will be named fleet-infra, which will be used by Flux. Generate a personal access token (PAT) with repo permissions, make sure to copy the generated token

```bash
# docker login ghcr.io -u ukrsite -p ghp_
# terraform apply -var "github_org=ukrsite" -var "github_token=ghp_" -var "github_repository=fleet-infra"
# kubectl create secret generic kbot --from-literal=token=ghp_ --dry-run=client -o yaml | kubectl apply -f -
# kubectl describe po -n demo
# curl -s https://fluxcd.io/install.sh | bash
# flux logs -f 
