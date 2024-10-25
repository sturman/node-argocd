# Node.js LTS alpine image with 'argocd' user and group

### Use case
The container image can be used for synthesizing [cdk8s](https://cdk8s.io/) TypeScript project in ArgoCD (see [ArgoCD Config Management Plugins](https://argo-cd.readthedocs.io/en/stable/operator-manual/config-management-plugins/))

### Available images

```
ghcr.io/sturman/node-argocd:lts-alpine
```

### Usage example

Here is an example how to use the container image in ArgoCD Config Management Plugin to synth `cdk8s` project

- add `cdk8s-cli` as dev dependencies to your project
- add npm script in `package.json`
```
  ...
  "scripts": {
    ...
    "argocd:synth": "cdk8s synth --stdout --check-upgrade=false"
  },
  ...
```
- add `cdk8s` plugin to ArgoCD. *(Example of ArgoCD helm chart values)*
```yaml
repoServer:
  extraContainers:
    - name: cdk8s
      command:
        - /var/run/argocd/argocd-cmp-server
      image: ghcr.io/sturman/node-argocd:lts-alpine # <-- container image where plugin commands will be executed
      securityContext:
        runAsNonRoot: true
        runAsUser: 999
      volumeMounts:
        - mountPath: /var/run/argocd
          name: var-files
        - mountPath: /home/argocd/cmp-server/plugins
          name: plugins
        - mountPath: /home/argocd/cmp-server/config/plugin.yaml
          subPath: plugin.yaml
          name: argocd-cmp-cm
        - mountPath: /tmp
          name: cmp-tmp
  volumes:
    - name: argocd-cmp-cm
      configMap:
        name: argocd-cmp-cm
        items:
          - key: cdk8s.yaml
            path: plugin.yaml
    - name: cmp-tmp
      emptyDir: {}
configs:
  cmp:
    create: true
    plugins:
      cdk8s:
        init:
          command: ["npm", "ci"]
        generate:
          command: ["npm", "run", "--silent", "argocd:synth"]
        discover:
          fileName: 'cdk8s.yaml'
```
- add a repository with `cdk8s` project (`cdk8s.yaml` file is required) to ArgoCD repositories.
- add ArgoCD Application
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
  name: dev-env
  namespace: argocd
spec:
  destination:
    namespace: dev
    server: https://kubernetes.default.svc
  project: default
  source:
    plugin:
      name: cdk8s
      env:
        - name: ENVIRONMENT
          value: dev
    repoURL: git@github.com:sturman/cdk8s-getting-started.git
    targetRevision: main
    path: './'
  syncPolicy:
    automated:
      prune: true
    syncOptions:
      - CreateNamespace=true
```
- commit & push cdk8s changes to `main` branch
- ArgoCD plugin should compile the cdk8s project and output all yaml manifests to stdout
- ArgoCD should apply all yaml manifests
