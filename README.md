
# 🛡️ ELK Stack Pentesting Lab (AWS Terraform Deployment)

This project creates a fully functional offensive security lab using AWS EC2 and Terraform. It includes:

- ✅ Kali Linux attacker machine
- ✅ Ubuntu victim machine running DVWA (Damn Vulnerable Web App)
- ✅ ELK Stack (Elasticsearch, Logstash, Kibana) for log collection and analysis

## 🌍 Region

All resources are deployed in: `us-east-1 (N. Virginia)`

---

## 🚀 Infrastructure Overview

| Role         | AMI                                 | Instance Type | Public IP        | Purpose                    |
|--------------|--------------------------------------|----------------|------------------|----------------------------|
| Kali Linux   | `ami-0cf57d4e3b64b608b`              | `t3.medium`    | Dynamic          | Attacker + pentest tools  |
| Victim       | Ubuntu 22.04 LTS                     | `t2.micro`     | Dynamic          | Runs DVWA vulnerable site |
| ELK Server   | Ubuntu 22.04 LTS                     | `t2.medium`    | Dynamic          | ELK Stack (ES, Logstash, Kibana) |

---

## 🔐 SSH Access

All instances use this key pair:
```
kali-key-east.pem
```

Access using:
```bash
ssh -i ~/Downloads/kali-key-east.pem ubuntu@<public-ip>     # for victim and ELK
ssh -i ~/Downloads/kali-key-east.pem kali@<public-ip>       # for Kali
```

---

## 🌐 URLs to Access

| Service   | URL Format                                   |
|-----------|----------------------------------------------|
| DVWA      | `http://<victim_public_ip>/dvwa`             |
| Kibana    | `http://<elk_public_ip>:5601`                |
| Elasticsearch | `http://<elk_public_ip>:9200`           |

---

## ⚙️ Terraform Commands

To deploy the lab:
```bash
terraform init
terraform apply
```

To shut down (pause billing):
```bash
# Stop from EC2 console or optionally use CLI
```

To destroy completely:
```bash
terraform destroy
```

---

## 📌 Notes

- DVWA is auto-installed on the victim via `user_data`
- ELK stack services are auto-installed and started
- Public IPs are dynamic unless Elastic IPs are attached
- Ports 22 (SSH), 80 (HTTP), 5601 (Kibana) are open

---

## ✅ Status

All components tested and confirmed working:
- [x] Kali SSH and tools
- [x] DVWA running on victim
- [x] Kibana and Elasticsearch accessible
