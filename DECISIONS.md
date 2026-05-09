# DECISIONS.md

### Decision: Use python:3.9-slim base image

**Context:**  
The original Dockerfile used a generic Python image which was large and unpinned.

**Options considered:**  
- python:latest → easy but not reproducible  
- python:3.9-slim → smaller and stable  

**Chosen:**  
python:3.9-slim  

**Rationale:**  
Provides a smaller attack surface and ensures reproducibility.

**Cost / risk:**  
Slightly fewer pre-installed tools compared to full image.

---

### Decision: Run container as non-root user

**Context:**  
The container was running as root, posing a security risk.

**Options considered:**  
- Run as root → simple but unsafe  
- Run as non-root → safer  

**Chosen:**  
Non-root user  

**Rationale:**  
Limits impact if container is compromised.

**Cost / risk:**  
Requires handling permissions properly.

---

### Decision: Add CPU and memory limits

**Context:**  
No resource constraints were defined in the deployment.

**Options considered:**  
- No limits → risk of resource exhaustion  
- Add limits → controlled usage  

**Chosen:**  
Defined requests and limits  

**Rationale:**  
Prevents a single container from affecting cluster stability.

**Cost / risk:**  
May require tuning based on workload.

---

### Decision: Move API token to Kubernetes Secret

**Context:**  
API token was hardcoded in values.yaml.

**Options considered:**  
- Keep in values.yaml → insecure  
- Use Kubernetes Secret → safer  

**Chosen:**  
Kubernetes Secret  

**Rationale:**  
Prevents exposure of sensitive data in repository.

**Cost / risk:**  
Still base64 encoded (not encrypted).

---

### Decision: Replace 'latest' tag with fixed version

**Context:**  
Using 'latest' makes deployments unpredictable.

**Options considered:**  
- latest → simple but unsafe  
- version tag → stable  

**Chosen:**  
Fixed version (1.0.0)

**Rationale:**  
Ensures reproducibility and easier debugging.

**Cost / risk:**  
Requires manual version updates.

---

### Decision: Enforce strict CI validation

**Context:**  
Original CI pipeline passed without meaningful checks.

**Options considered:**  
- Keep simple CI → fast but unsafe  
- Add validation → reliable  

**Chosen:**  
Added tests, helm lint, terraform validation  

**Rationale:**  
Ensures only valid and tested code is deployed.

**Cost / risk:**  
Longer pipeline execution time.

---

### Decision: Use Kyverno for policy enforcement

**Context:**  
The deployment lacked enforcement for security and reliability standards.

**Options considered:**  
- Gatekeeper → powerful but more complex  
- Kyverno → YAML-native and easier integration  

**Chosen:**  
Kyverno  

**Rationale:**  
Kyverno integrates naturally with Kubernetes YAML and is easier to maintain.

**Cost / risk:**  
Less expressive compared to Rego-based policies.

---

### Decision: Configure liveness and readiness probes

**Context:**  
The original health endpoint did not provide meaningful reliability checks.

**Options considered:**  
- No probes → simple but unreliable  
- Add probes → better reliability  

**Chosen:**  
Configured liveness and readiness probes  

**Rationale:**  
Allows Kubernetes to detect unhealthy pods and route traffic only to ready instances.

**Cost / risk:**  
Probe timing may need tuning in production.