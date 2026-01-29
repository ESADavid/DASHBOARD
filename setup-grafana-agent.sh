#!/bin/bash

# Add Grafana repo
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Create namespace
kubectl create namespace grafana-agent

# Install agent
helm install grafana-agent grafana/grafana-agent \
  --namespace grafana-agent \
  -f owlban-values.yaml

echo "Grafana agent setup complete!"
