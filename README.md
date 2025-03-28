# Simple-EKS-Kubernetes-Terraform

This project deploys an Nginx web server on Amazon EKS using Terraform.

## 📁 Folder Structure

Simple-EKS-Kubernetes-Terraform/
│── terraform/                # Terraform files
│   ├── main.tf               # Terraform configuration
│   ├── variables.tf          # Variables for Terraform
│   ├── outputs.tf            # Terraform output values
│   ├── provider.tf           # AWS provider configuration
│   ├── eks-cluster.tf        # EKS cluster setup
│── k8s-manifests/            # Kubernetes YAML files
│   ├── deployment.yaml       # Nginx Deployment
│   ├── service.yaml          # LoadBalancer Service
│── scripts/                  # Helper scripts
│   ├── setup-kubectl.sh      # Configure kubectl
│── README.md                 # Documentation
│── .gitignore                # Ignore Terraform state files

## 🚀 Quick Start

### 1️⃣ Deploy EKS Cluster
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### 2️⃣ Create EKS Node Group
Once your EKS cluster is up and running, you can create a node group using the AWS CLI. Here is an example of how to do it:

```sh
aws eks create-nodegroup \
  --cluster-name simple-eks-cluster \
  --nodegroup-name my-node-group \
  --subnets subnet-xxxxxxxxxxxxxxxxx subnet-yyyyyyyyyyyyyyyyy \
  --node-role arn:aws:iam::123456789012:role/your-eks-node-role \
  --scaling-config minSize=1,maxSize=3,desiredSize=2 \
  --instance-types t3.medium \
  --region us-east-1
```

#### 📌 Parameters Explanation:
- `--cluster-name` - The name of your EKS cluster.
- `--nodegroup-name` - A unique name for your node group.
- `--subnets` - Provide the subnet IDs where your nodes will run.
- `--node-role` - The IAM role assigned to your node instances.
- `--scaling-config` - Define the desired number of nodes and scaling limits.
- `--instance-types` - Specify the instance type (e.g., t3.medium).
- `--region` - The AWS region where your cluster is deployed.

#### ✅ Additional Tips:
- Ensure your node role has the necessary permissions.
- Subnets should be in the VPC associated with your EKS cluster.
- Use the following command to check the status of your node group:
  ```sh
  aws eks list-nodegroups --cluster-name simple-eks-cluster --region us-east-1
  ```
- If needed, delete a node group using:
  ```sh
  aws eks delete-nodegroup --cluster-name simple-eks-cluster --nodegroup-name my-node-group --region us-east-1
  ```

### 3️⃣ Configure `kubectl`
```sh
aws eks update-kubeconfig --region us-east-1 --name simple-eks-cluster
kubectl get nodes
```

### 4️⃣ Deploy Nginx on EKS
```sh
kubectl apply -f k8s-manifests/
kubectl get svc nginx-service
```

### 5️⃣ Access the Application
Get the **external IP**:
```sh
kubectl get svc nginx-service
```
Open the IP in your browser.

### 6️⃣ Cleanup Resources
```sh
terraform destroy -auto-approve
```
