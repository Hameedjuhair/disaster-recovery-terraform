# 🛡️ Disaster Recovery as Code (DRAC) – Terraform + AWS

This project implements a highly available and resilient cloud infrastructure using **Terraform** on **AWS**, with integrated **disaster recovery mechanisms**.

---

## 📌 Project Overview

- **Infrastructure-as-Code** with Terraform  
- **Modular Terraform design** (VPC, EC2, RDS, S3, Monitoring, Lambda, SNS)  
- **Automatic recovery** from EC2, RDS failures  
- **CloudWatch → SNS → Email** alerts  
- **Failover simulation** supported

---

## 📬 Email Alert Validation

SNS email alerts are triggered on:

- ❗ RDS Low Storage (CloudWatch alarm)  
- 🧪 Lambda manual invocation for disaster simulation

> ✅ Ensure your SNS email subscription is confirmed before testing.

---

## 📁 Directory Structure

```bash
disaster-recovery-terraform/
├── modules/
│   ├── ec2/
│   ├── rds/
│   ├── vpc/
│   ├── monitoring/
│   ├── lambda_trigger/
│   └── s3/
├── envs/
│   └── us-east-1/
│       └── main.tf
├── terraform.tfvars
└── README.md
```

---

## 📐 Architecture

![Architecture Diagram](../assets/architecture.png)

**Region:** `us-east-1`  
**Components:**

- VPC with 2 public subnets  
- EC2 (web server)  
- RDS (MySQL)  
- S3 (snapshot backup)  
- Lambda (DR trigger logic)  
- CloudWatch + SNS → Email alerts  

---

## 🚀 Deployment

### ✅ Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform ≥ v1.0 installed
- SNS email alert subscription confirmed

### ⚙️ Deploy Infrastructure

```bash
cd envs/us-east-1
terraform init
terraform plan
terraform apply
```

---

## 🧪 DR Testing Scenarios

| Test Case                 | Description                                        |
| ------------------------- | -------------------------------------------------- |
| EC2 Failover              | Simulate EC2 failure with `terraform taint`        |
| RDS Alert Trigger         | Stop RDS and verify SNS email alert via CloudWatch |
| Subnet AZ Isolation       | Fail one subnet and test fallback in the other     |
| Lambda Trigger Validation | Manually invoke Lambda and confirm SNS alert       |

---

## 🎥 Demo Video

📹 [Watch Demo on Google Drive](https://drive.google.com/file/d/167EFIBHzyB6cNo808zWcnw0j5zc9L39X/view?usp=sharing)

> Covers EC2 taint simulation, RDS alert trigger, and Lambda test

---

## 🧾 License

MIT © 2025 Hameed Juhair  
**Email:** [juhairhameed17@gmail.com](mailto:juhairhameed17@gmail.com)  
**GitHub:** [Hameedjuhair](https://github.com/Hameedjuhair)
