Accessing Web Dashboard
------------------------

Kubernetes has a nice Web Dashboard (if installed). To access it, open a proxy:

```bash
kubectl proxy
```

Then open [http://localhost:8081/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/]() in your browser. 

You will need a token to access it. There is a script, [`scripts/get-token.sh`](../scripts/get-token.sh), which will print a token in most cases.

