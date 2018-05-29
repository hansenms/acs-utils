Set Up Ingress Controller
-------------------------

Kubernetes services can be exposed outside the Kubernetes cluster with a `Service` resources. If you have many services in the cluster, exposing each of them with separate `Service` resources (e.g. Loadbalancers), would mean that there would be an IP endpoint for each of them. In many case, you would want access through a single IP and use a reverse proxy to direct traffic to the appropriate backend services and perform functions such as SSL offloading. This can be done with a combination of an Ingress Controller. An Ingress Resource specifies the routing rules. 

You can read more about [Ingress in the Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/ingress/) and some details on [how to set up an Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/). 

To set up an Ingress Controller, you can use a command such as:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
```

Next step is to Service to get connections to the Ingress controller:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml
```

This last command will expose an IP address for the Ingress Controller outside the Kubernetes cluster. The default is for the Ingress Controller to have a public IP. If you have a private cluster, you may want to use a private IP address. In that case, you can use the command:

```bash
kubectl apply -f https://raw.githubusercontent.com/hansenms/acs-utils/master/manifests/ingress-loadbalancer-internal.yaml
``` 

This will give the Ingress Controller an IP address in the local VNet.

You can check that the Ingress Controller is running with:

```bash
kubectl get pods --all-namespaces -l app=ingress-nginx
```

And find the external IP address of the Ingress Controller:

```bash
kubectl get svc --all-namespaces -l app=ingress-nginx
```

As an example of using the Ingress Controller for SSL termination, see instructions on deploying a [Web Site with SSL Certificate](website-ssl-cert.md)