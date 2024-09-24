# WordPress E-commerce Project: Deploying via LEMP Stack on AWS

This project automates the deployment of a WordPress-based e-commerce website using a LEMP (Linux, Nginx, MySQL/MariaDB, PHP) stack on AWS. The infrastructure is managed using CloudFormation, secured with Cloudflare, and integrated with CI/CD pipelines via GitHub Actions.

---

## Table of Contents

- [Overview](#overview)
- [Project Objectives](#project-objectives)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
- [CI/CD Integration](#cicd-integration)
- [Security Measures](#security-measures)
- [Monitoring and Maintenance](#monitoring-and-maintenance)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This project deploys an e-commerce platform using WordPress, specializing in protein products. The deployment leverages modern DevOps practices such as Infrastructure as Code (IaC), CI/CD pipelines, and cloud security measures to ensure performance, scalability, and security.

---

## Project Objectives

1. **Infrastructure Setup**: Automate the provisioning of a scalable and secure LEMP stack on AWS using CloudFormation.
2. **Website Deployment**: Set up WordPress as the content management system (CMS) for an e-commerce platform.
3. **Security**: Implement Cloudflare for DDoS protection and secure HTTPS using SSL certificates managed by Certbot.
4. **CI/CD Pipeline**: Automate testing, building, and deployment through GitHub Actions.
5. **Monitoring and Maintenance**: Implement AWS CloudWatch for monitoring the infrastructure and application health.

---

## Tech Stack

- **Cloud Provider**: AWS (EC2, RDS, S3, etc.)
- **Infrastructure**: CloudFormation for IaC
- **Web Server**: Nginx
- **Database**: MySQL/MariaDB
- **Language**: PHP (for WordPress)
- **Automation/CI**: GitHub Actions
- **Security**: Cloudflare, Certbot (for SSL)
- **Monitoring**: AWS CloudWatch

---

## Architecture

The architecture follows a cloud-native approach, deploying all infrastructure on AWS, leveraging CloudFormation templates to set up the LEMP stack. The main components are:

1. **LEMP Stack**: Linux OS (Amazon EC2), Nginx for web hosting, MariaDB/MySQL for database management, and PHP for WordPress.
2. **Cloudflare**: Provides security features such as DDoS protection, SSL termination, and CDN services.
3. **CloudFormation**: Automates infrastructure deployment and management.
4. **GitHub Actions**: Manages the CI/CD pipeline, automating deployment to AWS on each commit to the main branch.

---

## Setup Instructions

### Prerequisites

1. **AWS Account**: Ensure you have access to AWS and necessary permissions to create EC2 instances, RDS databases, and other resources.
2. **Domain and DNS**: A domain name registered with Cloudflare for DNS and security settings.
3. **GitHub Repository**: Fork or clone this repository to your GitHub account.

### Steps

1. **CloudFormation Deployment**:
   - Navigate to the AWS CloudFormation console.
   - Upload the provided CloudFormation template to provision the required infrastructure.
   - Set parameters such as instance type, database credentials, and domain name.

2. **Configure Cloudflare**:
   - Set up your domain in Cloudflare.
   - Point DNS records (A and CNAME) to the AWS infrastructure (EC2 public IP).
   - Enable SSL using Cloudflare's "Flexible" or "Full" SSL mode.

3. **Certbot SSL Configuration**:
   - Run Certbot on the EC2 instance to acquire an SSL certificate for HTTPS communication.
   - Configure Nginx to use the SSL certificate.

4. **Deploy WordPress**:
   - SSH into the EC2 instance.
   - Set up WordPress by running the WordPress installation script provided.
   - Complete the WordPress setup wizard from the browser.

---

## CI/CD Integration

### GitHub Actions

This repository uses GitHub Actions for automating the CI/CD pipeline. The workflow automates:

- **Build and Test**: Runs PHP unit tests for the WordPress installation.
- **Deploy**: Automates the deployment to AWS when new code is pushed to the main branch.
- **Security Checks**: Integrates security tools for vulnerability scanning and dependency checking.

To modify the CI/CD process, edit the `.github/workflows/deploy.yml` file as per your requirements.

---

## Security Measures

1. **Cloudflare**: Protects against DDoS attacks and optimizes website performance.
2. **SSL/TLS**: Certbot is used to manage SSL certificates for encrypted communication.
3. **Vulnerability Scanning**: Regularly scheduled scans are automated in the CI/CD pipeline using GitHub Actions.
4. **Access Control**: Follow AWS best practices by using IAM roles and least privilege principles.

---

## Monitoring and Maintenance

Monitoring and alerting are configured using AWS CloudWatch, tracking key metrics such as:

- **EC2 Health**: CPU, memory, disk usage.
- **Application Logs**: Real-time monitoring of logs for error detection.
- **Database Performance**: Monitoring RDS instances for query performance and connection issues.

Notifications can be set up via AWS SNS for any critical alerts.

---

## Contributing

We welcome contributions to improve this project. If you’d like to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

Please ensure all new features include unit tests and integration tests where applicable.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
