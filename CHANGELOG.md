# Not released yet
- Enable adding custom Chrome options via chart values.

# 0.4.0
- Enabled using external Selenium Grid (see `karaf.configs.externalSeleniumHubUrl`). You may skip running Selenium Grid by setting `sgrid.enabled=false` (which is enabled by default).
- Nginx Ingress Controller will be used now for local testing purposes.
- Raised ActiveMQ Deployment limits (CPU `150m` -> `250m`, Memory `150Mi` -> `250Mi`) to fix the initialisation failures.

# 0.3.1
- Fix mongodb service name logic.

# 0.3.0
- Use AET images from https://hub.docker.com/u/malaskowski.
- Enable configuring number of Selenium Grid nodes.
- Ingress API version upgraded.

# 0.2.0
Run MongoDB in `standalone` mode as Statefull Set and RollingUpdate.

# 0.1.0
First open-source release.
