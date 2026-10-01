# Bash Server Automation

## Overview

As part of Phase 4 of the Cloud DevOps roadmap, Bash scripting was used to automate basic EC2 server setup, service management, deployment, and health verification.

The automation was tested on a real AWS EC2 instance running Amazon Linux 2023.

## Environment

* AWS EC2
* Amazon Linux 2023
* Instance type: t3.micro
* Nginx web server
* Bash
* systemd / systemctl
* curl

## Automation Scripts

### `deploy.sh`

Automates the basic web-server deployment process.

The script:

1. Checks whether Nginx is already installed.
2. Installs Nginx using the available package manager when required.
3. Copies the project website to the Nginx web root.
4. Enables Nginx to start on boot.
5. Starts the Nginx service.
6. Verifies that Nginx is running.
7. Verifies a successful HTTP response.
8. Stops with a non-zero exit status if a required step fails.

The script supports both `dnf`-based and `apt`-based systems.

### `restart.sh`

Provides reusable service restart automation.

Usage:

```bash
./scripts/restart.sh <service-name>
```

The script:

* Validates that a service name was provided.
* Restarts the requested systemd service.
* Verifies that the service is running.
* Performs an HTTP health check.
* Returns a failure status if verification fails.

### `health-check.sh`

Performs a basic application health check.

The script verifies:

* Nginx is running.
* The local web server returns a successful HTTP response.

## Validation

The scripts were tested on a real AWS EC2 instance.

### Deployment

```text
Nginx is already installed.
Nginx is running.
Successful HTTP response.
Deployment successful.
```

### Health Check

```text
Nginx is running.
Successful HTTP response.
```

The deployed website was also verified through the EC2 public IPv4 address.

## Troubleshooting

### Nginx document root

Amazon Linux 2023 uses:

```text
/usr/share/nginx/html
```

rather than the Ubuntu/Debian default:

```text
/var/www/html
```

The deployment script therefore targets the Amazon Linux Nginx document root used during validation.

### SSH connectivity

SSH access depends on the EC2 security group's port 22 rule and the client's current public IP address.

If the client's public IP changes, the security group's SSH source may need to be updated.

### Script syntax validation

Before executing the deployment script, Bash syntax can be checked with:

```bash
bash -n scripts/deploy.sh
```

No output indicates that Bash did not detect a syntax error.

## Key Learning

This phase converted manual server operations into repeatable Bash automation.

The automation created in this phase will later serve as a foundation for the larger Auto-Healing Infrastructure project, where AWS services such as CloudWatch, SNS, Lambda, and Terraform will be introduced.

