# AUDIT.md

## 1. Fake health check

**Issue:**  
The `/healthz` endpoint always returned success without validating application state.

**Risk:**  
Kubernetes could treat unhealthy applications as healthy.

**Fix:**  
Configured liveness and readiness probes with better reliability settings.

---

## 2. Container running as root

**Issue:**  
The Docker container did not enforce non-root execution.

**Risk:**  
If compromised, attackers could gain elevated privileges.

**Fix:**  
Added non-root user in Dockerfile and enforced securityContext in Kubernetes.

---

## 3. Missing resource limits

**Issue:**  
Deployment lacked CPU and memory requests/limits.

**Risk:**  
Containers could consume excessive resources and destabilize the cluster.

**Fix:**  
Added CPU and memory requests and limits.

---

## 4. Hardcoded API token

**Issue:**  
Sensitive token was stored directly in values.yaml.

**Risk:**  
Secrets exposed in version control.

**Fix:**  
Moved token into Kubernetes Secret and referenced it via environment variables.

---

## 5. Use of latest image tag

**Issue:**  
Deployment used `latest` image tag.

**Risk:**  
Non-reproducible deployments and difficult debugging.

**Fix:**  
Replaced with fixed version tag.

---

## 6. Weak CI pipeline

**Issue:**  
CI pipeline did not perform meaningful validation.

**Risk:**  
Broken or insecure changes could pass CI.

**Fix:**  
Added testing, linting, Helm lint, Terraform validation, and Docker build verification.

---

## 7. Missing policy enforcement

**Issue:**  
No automated enforcement for security and resource requirements.

**Risk:**  
Future deployments could reintroduce unsafe configurations.

**Fix:**  
Added Kyverno policies for non-root enforcement and required resource limits.