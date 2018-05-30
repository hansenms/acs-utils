Website with SSL Certificate
-----------------------------

First [deploy an Ingress Controller](setup-ingress-controller.md). Locate the IP address of the Ingress Controller:

```bash
kubectl get svc --all-namespaces -l app=ingress-nginx
```

Create certificate secret:

```bash
kubectl create secret tls cloudynerd-us --cert /etc/letsencrypt/live/cloudynerd.us/fullchain.pem --key /etc/letsencrypt/live/cloudynerd.us/privkey.pem
```

Deploy the site:

```bash
kubectl apply -f manifests/web-service-ingress.yaml
```

Testing without DNS:

```bash
curl --resolve mycrazysite.cloudynerd.us:443:XX.XX.XX.XX https://mycrazysite.cloudynerd.us
```

Replace `XX.XX.XX.XX` with IP address.

