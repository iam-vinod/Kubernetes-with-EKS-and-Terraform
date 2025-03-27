module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster"
  cluster_version = "1.27"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  enable_irsa = true

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3

      instance_types = ["t3.medium"]
    }
  }
}
