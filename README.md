# StartTech Enterprise Application Cloud Infrastructure

Welcome to the primary DevOps orchestration and Infrastructure-as-Code repository for the StartTech Full-Stack system. This ecosystem structures a resilient, auto-scaling web runtime framework on AWS, fulfilling the core parameters specified within the Month 3 Performance Assessment.

## Architectural Ecosystem Framework

The system utilizes an automated delivery mesh across global infrastructure nodes:

* **Content Ingress Layer:** AWS CloudFront serves static Vite React assets directly out of security-isolated Amazon S3 buckets.
* **Web Compute API Runtime:** Go application executables contained inside runtime isolation layers, operating across elastic EC2 arrays inside a dedicated VPC.
* **Routing & High-Availability Mesh:** AWS Application Load Balancers target runtime endpoints across varying Availability Zones managed by an Auto Scaling Group.
* **Caching & State Persistence:** A managed Amazon ElastiCache Redis data architecture alongside remote secure clusters on MongoDB Atlas.

---

## Directory Schema Topology

```text
starttech-infra/
├── .github/
│   └── workflows/
│       └── infrastructure-deploy.yml # Auto Provisioning Engine
├── modules/
│   ├── networking/                  # VPC Subnets, IGW, and SG Boundaries
│   ├── compute/                     # Launch Templates & ASG Core Schemas
│   ├── storage/                     # S3 Static Assets & ElastiCache Redis
│   └── monitoring/                  # CloudWatch Targets & Log Clusters
├── cloudwatch-dashboard.json        # Unified Infrastructure Dashboard
├── alarm-definitions.json           # Threshold-Breach Security Alerting Schema
├── log-insights-queries.txt         # Containerized Debug Diagnostic Scripts
├── main.tf                          # Root Module Interfacing Entrypoint
├── variables.tf                     # Environmental Execution Declarations
└── README.md                        # Primary Operations Manual