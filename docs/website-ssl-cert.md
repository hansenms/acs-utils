Website with SSL Certificate
-----------------------------

Create certificate secret:

```bash
kubectl create secret tls cloudynerd-cert --cert /etc/letsencrypt/live/cloudynerd.us/fullchain.pem --key /etc/letsencrypt/live/cloudynerd.us/privkey.pem
```

Testing without DNS:

```bash
curl --resolve mycrazysite.cloudynerd.us:443:10.240.0.97 https://mycrazysite.cloudynerd.us
```

