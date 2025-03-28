#!/bin/bash

# Configure kubectl to connect to EKS cluster
aws eks update-kubeconfig --region us-east-1 --name example-eks-cluster

echo "kubectl configured to use EKS cluster."