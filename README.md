# devops-junior-test
Initial test to join Cloud Engineer team.

# DevOps Junior - Lab (task1)
 
## Overview
 
Create a web application hosted on Google Cloud Platform using
Cloud Storage for static content and
Compute Engine for administration.
The application should demonstrate understanding of cloud infrastructure,
security, and DevOps practices.
 
## Application Description
 
### EndUser Perspective
 
- Access public website through CDN/Load Balancer
- View static content (HTML/CSS/JavaScript) – (index.html - It doesn't really matter what's there)
- Experience fast loading times globally
- Subject to geographical access restrictions
 
### Admin Perspective
 
- Login to admin VM through secure VPC
- Access web-based admin panel
- Modify website content (HTML/CSS/JS files) by the special scripts v1 nad v2
- Changes automatically published to Cloud Storage
- Admin no direct bucket access
 
## Architecture communication flow.
 
    U[Users] --> LB[Load Balancer]
    LB --> CA[Cloud Armor]
    CA --> CS[Cloud Storage]
 
    A[Admin] --> AVM[Admin VM]
    AVM --> BVM[Backend VM]
    BVM --> CS
 
## GCP Components:
 
Cloud Storage (static website hosting)
Cloud Armor (security layer)
Load Balancer (traffic distribution)
Compute Engine (admin infrastructure)
VPC Networks (network isolation)
IAM & Service Accounts (access control)
 
## Implementation Requirements
 
### PC Environment Setup:
 
Windows 10/11 workstation
Visual Studio Code
Google Cloud SDK
Terraform v1.5+
Python 3.9+
Git
GitHub account
VSCode Extensions
HashiCorp Terraform
Google Cloud Tools
Python
GitHub Copilot for help ;-)
 
## Implementation Stages
 
### Stage 1: Environment Setup (~30 min - 3h)
 
        Deliverables:
        Environment configuration screenshots
        GCP project initialization
        Git repository setup
 
### Stage 2: GCloud Implementation (90 min - 4h)
 
        Deliverables:
        PowerShell deployment script
        Architecture diagram
        README documentation
        Connectivity test results
 
### Stage 3: Terraform Implementation (90 min - 5h)
      
        Deliverables:
        Terraform configuration files
        State management setup
        Variables documentation
        Infrastructure tests
 
### Stage 4: Admin Application (30 min - 4h)
       
        Deliverables:
        Python application code
        Deployment documentation
        Testing report
 
### Stage 5: Testing & Documentation (40 min - 2h)
       
        Deliverables:
        Test scenarios
        Security assessment
        Final architecture documentation
        Cost analysis
 
## Constraints
 
Budget: $50
Time: 4 days
Region: europe-central2 (Warsaw)
Must use specified GCP services
Security best practices required
Evaluation Criteria
Working solution
Infrastructure security
Code quality
Documentation quality
Cost optimization
 
VCS - Workspace Structure.
 
project/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── networking.tf
│   ├── storage.tf
│   ├── compute.tf
│   └── iam.tf
├── app/
│   ├── static/
│   └── admin/
└── scripts/
    └── deploy.ps1
 
## Notes
 
Use service accounts for all service interactions
Implement proper network isolation for public and admin conection
Document all security measures
Provide cost estimates
Include monitoring considerations