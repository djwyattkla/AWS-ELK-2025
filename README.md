
# ELK Pentesting Lab on AWS

![Terraform](https://img.shields.io/badge/Terraform-Ready-blueviolet?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws)
![License](https://img.shields.io/github/license/yourusername/elk-lab)

> A modular AWS-based lab for learning, pentesting, and monitoring using Kali Linux, DVWA, and the ELK Stack.

---

## 🌐 Architecture Overview

```
┌────────────┐        ┌────────────┐        ┌────────────┐
│   Kali EC2 │◄──────►│  Victim EC2│◄──────►│   ELK EC2  │
│ (t3.medium)│        │ (DVWA App) │        │ Kibana +   │
│ Attacker   │        │ Web Server │        │ Logstash   │
└────────────┘        └────────────┘        │ Elasticsearch │
                                            └────────────┘
         All resources are deployed in AWS us-east-1
```

## 🚀 Features

- ✅ Kali Linux attacker node with public SSH access
- ✅ Ubuntu victim machine running DVWA
- ✅ ELK Stack (Kibana on port 5601)
- ✅ Public access security group for testing
- ✅ Ideal for CTFs, blue/red team exercises, and SOC training

## 🔧 Prerequisites

- Terraform CLI
- AWS CLI (configured)
- An existing key pair in the target region

## 🏗️ Deployment

```bash
terraform init
terraform apply
```

> Ensure you select the correct AWS region (`us-east-1`) and have valid SSH key access configured.

## 📜 Notes

- SSH, HTTP, and Kibana ports are exposed to `0.0.0.0/0` — intended for isolated test environments
- Consider adding IP restrictions or VPN for more secure use

## 🧹 Cleanup

```bash
terraform destroy
```

## 📂 Files Included

- `main.tf` – defines all EC2 instances and networking
- `.gitignore` – excludes state files and credentials
- `README.md` – project overview and usage instructions

## 📸 Banner (Optional)

![ELK Lab Banner](https://dummyimage.com/1000x250/000000/00ffcc.png&text=ELK+Pentest+Lab+on+AWS)

## 📄 License

This project is licensed under the MIT License.
