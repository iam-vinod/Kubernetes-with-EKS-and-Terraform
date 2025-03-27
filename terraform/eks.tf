module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.0.0" # Or the latest stable version

  cluster_name    = "eks-cluster"
  cluster_version = "1.27"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    eks-node-group = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}
