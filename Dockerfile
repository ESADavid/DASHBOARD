FROM grafana/grafana:latest

# Copy the dashboard JSON file
COPY dashboard.json /var/lib/grafana/dashboards/dashboard.json

# Create provisioning directory and config
RUN mkdir -p /etc/grafana/provisioning/dashboards
COPY dashboard.yml /etc/grafana/provisioning/dashboards/dashboard.yml

# Expose port
EXPOSE 3000

# Set environment variables
ENV GF_SECURITY_ADMIN_PASSWORD=SecureGrafanaP@ss2024
