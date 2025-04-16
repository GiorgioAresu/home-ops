```shell
task talos:generate-clusterconfig
task k8s-bootstrap:talos
task k8s-bootstrap:apps
```

[WebHook Setup](https://github.com/onedr0p/cluster-template?tab=readme-ov-file#-github-webhook) using the following command for the hook path
```shell
kubectl -n flux-system get receiver flux-system --output=jsonpath='{.status.webhookPath}'
```
