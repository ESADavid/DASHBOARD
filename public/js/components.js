// Page Components and Templates

const components = {
    // Home Page
    home: () => `
        <section class="hero">
            <div class="container">
                <div class="hero-content fade-in">
                    <h1 class="hero-title">Enterprise Cloud Infrastructure</h1>
                    <p class="hero-subtitle">
                        Deploy, scale, and manage your applications with confidence on our global cloud platform.
                        Choose from Virtual Machines, Containers, Bare Metal, and more.
                    </p>
                    <div class="btn-group">
                        <a href="#virtual-machines" class="btn btn-primary btn-large">Get Started</a>
                        <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                    </div>
                    <div class="hero-stats">
                        <div class="stat-item">
                            <span class="stat-value">99.99%</span>
                            <span class="stat-label">Uptime SLA</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-value">50+</span>
                            <span class="stat-label">Global Regions</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-value">24/7</span>
                            <span class="stat-label">Support</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Our Cloud Services</h2>
                    <p class="section-subtitle">
                        Choose the right infrastructure for your workload
                    </p>
                </div>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h3>Virtual Machines</h3>
                        <p>Scalable compute instances with flexible configurations. Perfect for traditional applications and workloads.</p>
                        <a href="#virtual-machines" class="btn btn-secondary mt-3">Learn More →</a>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fab fa-docker"></i>
                        </div>
                        <h3>Containers</h3>
                        <p>Managed Kubernetes and container orchestration. Deploy microservices with ease and scale automatically.</p>
                        <a href="#containers" class="btn btn-secondary mt-3">Learn More →</a>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-hdd"></i>
                        </div>
                        <h3>Bare Metal</h3>
                        <p>Dedicated physical servers for maximum performance. No virtualization overhead, complete control.</p>
                        <a href="#bare-metal" class="btn btn-secondary mt-3">Learn More →</a>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Confidential Compute</h3>
                        <p>Hardware-based security for sensitive workloads. Encrypt data in use with AMD SEV and Intel SGX.</p>
                        <a href="#confidential-compute" class="btn btn-secondary mt-3">Learn More →</a>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h3>Clusters</h3>
                        <p>Managed database and application clusters. High availability and automatic failover built-in.</p>
                        <a href="#clusters" class="btn btn-secondary mt-3">Learn More →</a>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h3>Global Network</h3>
                        <p>Low-latency connectivity across 50+ regions. Private networking and DDoS protection included.</p>
                        <a href="#pricing" class="btn btn-secondary mt-3">View Pricing →</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Why Choose Cloud.io?</h2>
                </div>
                <div class="grid grid-3">
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h3 class="card-title">Lightning Fast</h3>
                        <p class="card-description">
                            Deploy in seconds with our optimized infrastructure. NVMe SSDs and high-performance networking standard.
                        </p>
                    </div>
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h3 class="card-title">Enterprise Security</h3>
                        <p class="card-description">
                            SOC 2, ISO 27001, and HIPAA compliant. Advanced DDoS protection and encryption at rest and in transit.
                        </p>
                    </div>
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3 class="card-title">Auto Scaling</h3>
                        <p class="card-description">
                            Scale automatically based on demand. Pay only for what you use with per-second billing.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Virtual Machines Page
    virtualMachines: () => `
        <section class="service-hero">
            <div class="container">
                <div class="service-hero-icon">
                    <i class="fas fa-server"></i>
                </div>
                <h1 class="service-hero-title">Virtual Machines</h1>
                <p class="service-hero-description">
                    Scalable, high-performance virtual machines for any workload. Choose from general purpose, 
                    compute optimized, memory optimized, or GPU instances.
                </p>
                <div class="btn-group">
                    <a href="https://console.cloud.io.net/vms/create" class="btn btn-primary btn-large">Create VM</a>
                    <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Key Features</h2>
                <div class="service-features">
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-rocket"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Deploy in Seconds</h3>
                            <p>Launch VMs instantly from our library of pre-configured images or upload your own. Automated provisioning and configuration management.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Flexible Scaling</h3>
                            <p>Scale vertically by resizing instances or horizontally with auto-scaling groups. No downtime required for most operations.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>High-Performance Storage</h3>
                            <p>NVMe SSD storage with up to 1M IOPS. Automated backups and snapshots for data protection.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Advanced Networking</h3>
                            <p>Private networking, floating IPs, and load balancers. Up to 100 Gbps network throughput.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">VM Instance Types</h2>
                <table class="specs-table">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>vCPUs</th>
                            <th>Memory</th>
                            <th>Storage</th>
                            <th>Network</th>
                            <th>Starting Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>General Purpose</strong></td>
                            <td>1-96</td>
                            <td>2-384 GB</td>
                            <td>25-3200 GB SSD</td>
                            <td>Up to 25 Gbps</td>
                            <td>$5/month</td>
                        </tr>
                        <tr>
                            <td><strong>Compute Optimized</strong></td>
                            <td>2-96</td>
                            <td>4-192 GB</td>
                            <td>25-1600 GB SSD</td>
                            <td>Up to 50 Gbps</td>
                            <td>$12/month</td>
                        </tr>
                        <tr>
                            <td><strong>Memory Optimized</strong></td>
                            <td>2-96</td>
                            <td>16-768 GB</td>
                            <td>25-3200 GB SSD</td>
                            <td>Up to 50 Gbps</td>
                            <td>$18/month</td>
                        </tr>
                        <tr>
                            <td><strong>GPU Instances</strong></td>
                            <td>8-96</td>
                            <td>64-768 GB</td>
                            <td>100-3200 GB SSD</td>
                            <td>Up to 100 Gbps</td>
                            <td>$90/month</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Use Cases</h2>
                <div class="use-cases-grid">
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h3 class="use-case-title">Web Hosting</h3>
                        <p class="use-case-description">Host websites and web applications with high availability and performance.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-code"></i>
                        </div>
                        <h3 class="use-case-title">Development & Testing</h3>
                        <p class="use-case-description">Spin up dev environments quickly and tear them down when done.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h3 class="use-case-title">Database Servers</h3>
                        <p class="use-case-description">Run MySQL, PostgreSQL, MongoDB, and other databases with high IOPS.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3 class="use-case-title">Big Data Analytics</h3>
                        <p class="use-case-description">Process large datasets with compute and memory optimized instances.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <div class="getting-started">
                    <h2>Getting Started</h2>
                    <div class="steps-container">
                        <div class="step-item">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h3>Choose Your Instance Type</h3>
                                <p>Select the VM configuration that matches your workload requirements.</p>
                                <div class="code-block">
                                    <pre><code>cloud-cli vm create --type general-purpose-2vcpu-4gb --region nyc1</code></pre>
                                </div>
                            </div>
                        </div>
                        <div class="step-item">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h3>Configure & Deploy</h3>
                                <p>Set up networking, storage, and security settings. Deploy with one click.</p>
                                <div class="code-block">
                                    <pre><code>cloud-cli vm configure --ssh-keys ~/.ssh/id_rsa.pub --firewall web</code></pre>
                                </div>
                            </div>
                        </div>
                        <div class="step-item">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h3>Connect & Scale</h3>
                                <p>SSH into your VM and start deploying applications. Scale as needed.</p>
                                <div class="code-block">
                                    <pre><code>ssh root@your-vm-ip
cloud-cli vm resize --type general-purpose-4vcpu-8gb</code></pre>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Containers Page
    containers: () => `
        <section class="service-hero">
            <div class="container">
                <div class="service-hero-icon">
                    <i class="fab fa-docker"></i>
                </div>
                <h1 class="service-hero-title">Container Services</h1>
                <p class="service-hero-description">
                    Managed Kubernetes and container orchestration platform. Deploy, scale, and manage containerized 
                    applications with ease. Fully compatible with Docker and Kubernetes.
                </p>
                <div class="btn-group">
                    <a href="https://console.cloud.io.net/kubernetes/create" class="btn btn-primary btn-large">Create Cluster</a>
                    <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Kubernetes Features</h2>
                <div class="service-features">
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Fully Managed Kubernetes</h3>
                            <p>We handle the control plane, upgrades, and maintenance. You focus on deploying applications. Free control plane included.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-layer-group"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Auto-Scaling</h3>
                            <p>Horizontal Pod Autoscaler and Cluster Autoscaler built-in. Scale based on CPU, memory, or custom metrics.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Enterprise Security</h3>
                            <p>RBAC, network policies, and pod security policies. Integration with secrets management and image scanning.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Monitoring & Logging</h3>
                            <p>Built-in Prometheus and Grafana. Centralized logging with Elasticsearch and Kibana integration.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Cluster Configurations</h2>
                <div class="pricing-grid">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Development</h3>
                            <div class="pricing-price">$10<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 1-3 Worker Nodes</li>
                            <li><i class="fas fa-check"></i> 2 vCPU, 4GB RAM per node</li>
                            <li><i class="fas fa-check"></i> 50GB SSD Storage</li>
                            <li><i class="fas fa-check"></i> Free Control Plane</li>
                            <li><i class="fas fa-check"></i> Community Support</li>
                        </ul>
                        <a href="https://console.cloud.io.net/kubernetes/create?plan=dev" class="btn btn-secondary">Get Started</a>
                    </div>
                    <div class="pricing-card featured">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Production</h3>
                            <div class="pricing-price">$40<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 3-10 Worker Nodes</li>
                            <li><i class="fas fa-check"></i> 4 vCPU, 8GB RAM per node</li>
                            <li><i class="fas fa-check"></i> 100GB SSD Storage</li>
                            <li><i class="fas fa-check"></i> HA Control Plane</li>
                            <li><i class="fas fa-check"></i> 24/7 Support</li>
                            <li><i class="fas fa-check"></i> Auto-scaling</li>
                        </ul>
                        <a href="https://console.cloud.io.net/kubernetes/create?plan=prod" class="btn btn-primary">Get Started</a>
                    </div>
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Enterprise</h3>
                            <div class="pricing-price">Custom</div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Unlimited Nodes</li>
                            <li><i class="fas fa-check"></i> Custom Node Sizes</li>
                            <li><i class="fas fa-check"></i> Dedicated Resources</li>
                            <li><i class="fas fa-check"></i> Multi-Region HA</li>
                            <li><i class="fas fa-check"></i> Priority Support</li>
                            <li><i class="fas fa-check"></i> SLA Guarantees</li>
                        </ul>
                        <a href="#contact" class="btn btn-secondary">Contact Sales</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Quick Start Guide</h2>
                <div class="getting-started">
                    <div class="tabs">
                        <div class="tab-buttons">
                            <button class="tab-button active" data-tab="kubectl">kubectl</button>
                            <button class="tab-button" data-tab="helm">Helm</button>
                            <button class="tab-button" data-tab="docker">Docker</button>
                        </div>
                        <div class="tab-content active" id="kubectl">
                            <h3>Deploy with kubectl</h3>
                            <div class="code-block">
                                <pre><code># Connect to your cluster
cloud-cli kubernetes get-credentials my-cluster

# Deploy an application
kubectl create deployment nginx --image=nginx

# Expose the deployment
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Check status
kubectl get services</code></pre>
                            </div>
                        </div>
                        <div class="tab-content" id="helm">
                            <h3>Deploy with Helm</h3>
                            <div class="code-block">
                                <pre><code># Add Helm repository
helm repo add stable https://charts.helm.sh/stable

# Install a chart
helm install my-release stable/mysql

# List releases
helm list

# Upgrade release
helm upgrade my-release stable/mysql</code></pre>
                            </div>
                        </div>
                        <div class="tab-content" id="docker">
                            <h3>Build and Push Docker Images</h3>
                            <div class="code-block">
                                <pre><code># Build your image
docker build -t registry.cloud.io.net/myapp:v1 .

# Login to registry
docker login registry.cloud.io.net

# Push image
docker push registry.cloud.io.net/myapp:v1

# Deploy to Kubernetes
kubectl set image deployment/myapp myapp=registry.cloud.io.net/myapp:v1</code></pre>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Use Cases</h2>
                <div class="use-cases-grid">
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <h3 class="use-case-title">Microservices</h3>
                        <p class="use-case-description">Deploy and manage microservices architectures with service mesh integration.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h3 class="use-case-title">CI/CD Pipelines</h3>
                        <p class="use-case-description">Run build and deployment pipelines with GitOps and automated testing.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-robot"></i>
                        </div>
                        <h3 class="use-case-title">ML Workloads</h3>
                        <p class="use-case-description">Train and serve machine learning models with GPU support and auto-scaling.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="use-case-title">API Backends</h3>
                        <p class="use-case-description">Host scalable API services with load balancing and auto-scaling.</p>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Bare Metal Page
    bareMetal: () => `
        <section class="service-hero">
            <div class="container">
                <div class="service-hero-icon">
                    <i class="fas fa-hdd"></i>
                </div>
                <h1 class="service-hero-title">Bare Metal Servers</h1>
                <p class="service-hero-description">
                    Dedicated physical servers with no virtualization overhead. Maximum performance, complete control, 
                    and direct hardware access for demanding workloads.
                </p>
                <div class="btn-group">
                    <a href="https://console.cloud.io.net/bare-metal/create" class="btn btn-primary btn-large">Deploy Server</a>
                    <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Why Bare Metal?</h2>
                <div class="service-features">
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Maximum Performance</h3>
                            <p>No hypervisor overhead. Direct access to CPU, memory, and storage for peak performance. Perfect for high-throughput applications.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Complete Isolation</h3>
                            <p>Physical isolation from other tenants. No noisy neighbors. Ideal for compliance and security-sensitive workloads.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-microchip"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Custom Hardware</h3>
                            <p>Choose from Intel, AMD, or ARM processors. Configure RAID, add GPUs, or customize networking to your exact needs.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Rapid Provisioning</h3>
                            <p>Deploy in minutes, not days. Automated provisioning with IPMI access and remote management included.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Server Configurations</h2>
                <table class="specs-table">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Processor</th>
                            <th>RAM</th>
                            <th>Storage</th>
                            <th>Network</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Entry</strong></td>
                            <td>Intel Xeon E-2288G<br/>8 cores @ 3.7GHz</td>
                            <td>32 GB DDR4</td>
                            <td>2x 480GB SSD</td>
                            <td>1 Gbps</td>
                            <td>$99/month</td>
                        </tr>
                        <tr>
                            <td><strong>Performance</strong></td>
                            <td>AMD EPYC 7443P<br/>24 cores @ 2.85GHz</td>
                            <td>128 GB DDR4</td>
                            <td>2x 960GB NVMe</td>
                            <td>10 Gbps</td>
                            <td>$249/month</td>
                        </tr>
                        <tr>
                            <td><strong>High Memory</strong></td>
                            <td>Intel Xeon Gold 6342<br/>24 cores @ 2.8GHz</td>
                            <td>512 GB DDR4</td>
                            <td>4x 1.92TB NVMe</td>
                            <td>25 Gbps</td>
                            <td>$499/month</td>
                        </tr>
                        <tr>
                            <td><strong>GPU Accelerated</strong></td>
                            <td>AMD EPYC 7543<br/>32 cores @ 2.8GHz</td>
                            <td>256 GB DDR4</td>
                            <td>4x 3.84TB NVMe</td>
                            <td>25 Gbps</td>
                            <td>$899/month</td>
                        </tr>
                    </tbody>
                </table>
                <div class="info-box mt-4">
                    <div class="info-box-title">
                        <i class="fas fa-info-circle"></i>
                        Custom Configurations Available
                    </div>
                    <div class="info-box-content">
                        Need a specific configuration? Contact our sales team for custom hardware builds, 
                        including specialized GPUs, high-capacity storage, or unique networking requirements.
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Perfect For</h2>
                <div class="use-cases-grid">
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h3 class="use-case-title">High-Performance Databases</h3>
                        <p class="use-case-description">Run large-scale databases with maximum IOPS and minimal latency.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h3 class="use-case-title">AI/ML Training</h3>
                        <p class="use-case-description">Train large models with GPU acceleration and high-bandwidth storage.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-video"></i>
                        </div>
                        <h3 class="use-case-title">Media Processing</h3>
                        <p class="use-case-description">Encode, transcode, and render video with dedicated hardware.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-gamepad"></i>
                        </div>
                        <h3 class="use-case-title">Game Servers</h3>
                        <p class="use-case-description">Host multiplayer game servers with low latency and high performance.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <div class="getting-started">
                    <h2>Deployment Process</h2>
                    <div class="steps-container">
                        <div class="step-item">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h3>Select Configuration</h3>
                                <p>Choose from our pre-configured servers or build a custom configuration.</p>
                            </div>
                        </div>
                        <div class="step-item">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h3>Automated Provisioning</h3>
                                <p>Server is provisioned and configured automatically. Typically ready in 10-15 minutes.</p>
                            </div>
                        </div>
                        <div class="step-item">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h3>Access & Deploy</h3>
                                <p>Receive IPMI credentials and SSH access. Deploy your applications immediately.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Confidential Compute Page
    confidentialCompute: () => `
        <section class="service-hero">
            <div class="container">
                <div class="service-hero-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h1 class="service-hero-title">Confidential Compute</h1>
                <p class="service-hero-description">
                    Hardware-based security for your most sensitive workloads. Encrypt data in use with AMD SEV, 
                    Intel SGX, and ARM TrustZone. Meet compliance requirements with ease.
                </p>
                <div class="btn-group">
                    <a href="https://console.cloud.io.net/confidential/create" class="btn btn-primary btn-large">Get Started</a>
                    <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Security Features</h2>
                <div class="service-features">
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Memory Encryption</h3>
                            <p>AMD SEV-SNP and Intel TDX encrypt memory at the hardware level. Data remains encrypted even from the hypervisor.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-certificate"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Attestation</h3>
                            <p>Cryptographic proof that your workload is running in a trusted execution environment. Verify before processing sensitive data.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Zero Trust Architecture</h3>
                            <p>Protect data from insider threats and compromised infrastructure. Even cloud providers can't access your data.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-balance-scale"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Compliance Ready</h3>
                            <p>Meet GDPR, HIPAA, PCI-DSS, and other regulatory requirements with hardware-based security.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Technology Options</h2>
                <div class="comparison-table">
                    <table>
                        <thead>
                            <tr>
                                <th class="feature-name">Feature</th>
                                <th>AMD SEV-SNP</th>
                                <th>Intel TDX</th>
                                <th>Intel SGX</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="feature-name">Full VM Encryption</td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-times cross"></i></td>
                            </tr>
                            <tr>
                                <td class="feature-name">Memory Encryption</td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-check check"></i></td>
                            </tr>
                            <tr>
                                <td class="feature-name">Attestation</td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-check check"></i></td>
                                <td><i class="fas fa-check check"></i></td>
                            </tr>
                            <tr>
                                <td class="feature-name">Enclave Size</td>
                                <td>Unlimited</td>
                                <td>Unlimited</td>
                                <td>Limited (256MB)</td>
                            </tr>
                            <tr>
                                <td class="feature-name">Performance Impact</td>
                                <td>~5%</td>
                                <td>~5%</td>
                                <td>~10-20%</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Use Cases</h2>
                <div class="use-cases-grid">
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <h3 class="use-case-title">Healthcare Data</h3>
                        <p class="use-case-description">Process PHI and medical records with HIPAA-compliant encryption.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-university"></i>
                        </div>
                        <h3 class="use-case-title">Financial Services</h3>
                        <p class="use-case-description">Secure payment processing and fraud detection with PCI-DSS compliance.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-key"></i>
                        </div>
                        <h3 class="use-case-title">Key Management</h3>
                        <p class="use-case-description">Store and manage encryption keys in hardware-protected enclaves.</p>
                    </div>
                    <div class="use-case-card">
                        <div class="use-case-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="use-case-title">Multi-Party Compute</h3>
                        <p class="use-case-description">Collaborate on sensitive data without exposing it to any party.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <div class="getting-started">
                    <h2>Getting Started</h2>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle alert-icon"></i>
                        <div class="alert-content">
                            <h4>Prerequisites</h4>
                            <p>Confidential computing requires specific hardware and software support. Ensure your application is compatible with the chosen technology.</p>
                        </div>
                    </div>
                    <div class="code-block">
                        <pre><code># Create a confidential VM with AMD SEV-SNP
cloud-cli vm create \\
  --type confidential-4vcpu-8gb \\
  --technology amd-sev-snp \\
  --region nyc1

# Verify attestation
cloud-cli confidential verify-attestation --vm-id <vm-id>

# Deploy your application
ssh root@your-vm-ip
docker run --security-opt seccomp=unconfined your-app</code></pre>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Clusters Page
    clusters: () => `
        <section class="service-hero">
            <div class="container">
                <div class="service-hero-icon">
                    <i class="fas fa-network-wired"></i>
                </div>
                <h1 class="service-hero-title">Managed Clusters</h1>
                <p class="service-hero-description">
                    High-availability database and application clusters with automatic failover. 
                    PostgreSQL, MySQL, Redis, MongoDB, and more. Fully managed with automated backups.
                </p>
                <div class="btn-group">
                    <a href="https://console.cloud.io.net/clusters/create" class="btn btn-primary btn-large">Create Cluster</a>
                    <a href="#pricing" class="btn btn-secondary btn-large">View Pricing</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Supported Databases</h2>
                <div class="grid grid-4">
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h3 class="card-title">PostgreSQL</h3>
                        <p class="card-description">Versions 12, 13, 14, 15, 16. Streaming replication and automatic failover.</p>
                    </div>
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h3 class="card-title">MySQL</h3>
                        <p class="card-description">Versions 5.7, 8.0. Group replication with multi-primary support.</p>
                    </div>
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h3 class="card-title">Redis</h3>
                        <p class="card-description">Versions 6.x, 7.x. Sentinel and Cluster modes with persistence.</p>
                    </div>
                    <div class="card">
                        <div class="card-icon">
                            <i class="fas fa-leaf"></i>
                        </div>
                        <h3 class="card-title">MongoDB</h3>
                        <p class="card-description">Versions 5.x, 6.x, 7.x. Replica sets and sharded clusters.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Cluster Features</h2>
                <div class="service-features">
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Automatic Failover</h3>
                            <p>Detect failures in seconds and promote replicas automatically. Zero-downtime maintenance and upgrades.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-save"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Automated Backups</h3>
                            <p>Daily backups with point-in-time recovery. Retain backups for up to 35 days. One-click restore.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Performance Monitoring</h3>
                            <p>Real-time metrics and query analytics. Slow query detection and optimization recommendations.</p>
                        </div>
                    </div>
                    <div class="service-feature-item">
                        <div class="service-feature-icon">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </div>
                        <div class="service-feature-content">
                            <h3>Easy Scaling</h3>
                            <p>Scale vertically with zero downtime. Add read replicas with one click. Automatic load balancing.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Cluster Configurations</h2>
                <div class="pricing-grid">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Basic</h3>
                            <div class="pricing-price">$15<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 1 Primary Node</li>
                            <li><i class="fas fa-check"></i> 1 vCPU, 1GB RAM</li>
                            <li><i class="fas fa-check"></i> 10GB Storage</li>
                            <li><i class="fas fa-check"></i> Daily Backups</li>
                            <li><i class="fas fa-check"></i> Community Support</li>
                        </ul>
                        <a href="https://console.cloud.io.net/clusters/create?plan=basic" class="btn btn-secondary">Get Started</a>
                    </div>
                    <div class="pricing-card featured">
                        <div class="pricing-header">
                            <h3 class="pricing-title">High Availability</h3>
                            <div class="pricing-price">$60<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 1 Primary + 2 Replicas</li>
                            <li><i class="fas fa-check"></i> 2 vCPU, 4GB RAM</li>
                            <li><i class="fas fa-check"></i> 50GB Storage</li>
                            <li><i class="fas fa-check"></i> Automatic Failover</li>
                            <li><i class="fas fa-check"></i> Point-in-Time Recovery</li>
                            <li><i class="fas fa-check"></i> 24/7 Support</li>
                        </ul>
                        <a href="https://console.cloud.io.net/clusters/create?plan=ha" class="btn btn-primary">Get Started</a>
                    </div>
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Enterprise</h3>
                            <div class="pricing-price">Custom</div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Custom Topology</li>
                            <li><i class="fas fa-check"></i> Dedicated Resources</li>
                            <li><i class="fas fa-check"></i> Unlimited Storage</li>
                            <li><i class="fas fa-check"></i> Multi-Region Replication</li>
                            <li><i class="fas fa-check"></i> Priority Support</li>
                            <li><i class="fas fa-check"></i> SLA Guarantees</li>
                        </ul>
                        <a href="#contact" class="btn btn-secondary">Contact Sales</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <div class="getting-started">
                    <h2>Quick Start</h2>
                    <div class="tabs">
                        <div class="tab-buttons">
                            <button class="tab-button active" data-tab="postgresql">PostgreSQL</button>
                            <button class="tab-button" data-tab="mysql">MySQL</button>
                            <button class="tab-button" data-tab="redis">Redis</button>
                        </div>
                        <div class="tab-content active" id="postgresql">
                            <h3>Create PostgreSQL Cluster</h3>
                            <div class="code-block">
                                <pre><code># Create a PostgreSQL cluster
cloud-cli cluster create \\
  --type postgresql \\
  --version 16 \\
  --nodes 3 \\
  --size db-2vcpu-4gb

# Get connection string
cloud-cli cluster connection my-postgres-cluster

# Connect to database
psql "postgresql://user:pass@host:5432/defaultdb?sslmode=require"</code></pre>
                            </div>
                        </div>
                        <div class="tab-content" id="mysql">
                            <h3>Create MySQL Cluster</h3>
                            <div class="code-block">
                                <pre><code># Create a MySQL cluster
cloud-cli cluster create \\
  --type mysql \\
  --version 8.0 \\
  --nodes 3 \\
  --size db-2vcpu-4gb

# Get connection details
cloud-cli cluster connection my-mysql-cluster

# Connect to database
mysql -h host -u user -p defaultdb</code></pre>
                            </div>
                        </div>
                        <div class="tab-content" id="redis">
                            <h3>Create Redis Cluster</h3>
                            <div class="code-block">
                                <pre><code># Create a Redis cluster
cloud-cli cluster create \\
  --type redis \\
  --version 7.2 \\
  --mode cluster \\
  --nodes 6

# Get connection details
cloud-cli cluster connection my-redis-cluster

# Connect with redis-cli
redis-cli -h host -p 6379 -a password</code></pre>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    `,

    // Pricing Page
    pricing: () => `
        <section class="service-hero">
            <div class="container">
                <h1 class="service-hero-title">Simple, Transparent Pricing</h1>
                <p class="service-hero-description">
                    Pay only for what you use. No hidden fees, no surprises. All plans include 24/7 support and 99.99% uptime SLA.
                </p>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title">Virtual Machines</h2>
                <div class="pricing-grid">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Starter</h3>
                            <div class="pricing-price">$5<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 1 vCPU</li>
                            <li><i class="fas fa-check"></i> 2GB RAM</li>
                            <li><i class="fas fa-check"></i> 50GB SSD</li>
                            <li><i class="fas fa-check"></i> 2TB Transfer</li>
                        </ul>
                        <a href="https://console.cloud.io.net/vms/create?plan=starter" class="btn btn-primary">Deploy Now</a>
                    </div>
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Professional</h3>
                            <div class="pricing-price">$18<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 2 vCPU</li>
                            <li><i class="fas fa-check"></i> 4GB RAM</li>
                            <li><i class="fas fa-check"></i> 80GB SSD</li>
                            <li><i class="fas fa-check"></i> 4TB Transfer</li>
                        </ul>
                        <a href="https://console.cloud.io.net/vms/create?plan=professional" class="btn btn-primary">Deploy Now</a>
                    </div>
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3 class="pricing-title">Business</h3>
                            <div class="pricing-price">$48<span>/month</span></div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 4 vCPU</li>
                            <li><i class="fas fa-check"></i> 8GB RAM</li>
                            <li><i class="fas fa-check"></i> 160GB SSD</li>
                            <li><i class="fas fa-check"></i> 5TB Transfer</li>
                        </ul>
                        <a href="https://console.cloud.io.net/vms/create?plan=business" class="btn btn-primary">Deploy Now</a>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <a href="#virtual-machines" class="btn btn-secondary">View All VM Plans →</a>
                </div>
            </div>
        </section>

        <section class="section" style="background: var(--dark-card);">
            <div class="container">
                <h2 class="section-title">Additional Services</h2>
                <table class="specs-table">
                    <thead>
                        <tr>
                            <th>Service</th>
                            <th>Description</th>
                            <th>Starting Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Kubernetes</strong></td>
                            <td>Managed Kubernetes clusters with free control plane</td>
                            <td>$10/month per node</td>
                        </tr>
                        <tr>
                            <td><strong>Bare Metal</strong></td>
                            <td>Dedicated physical servers</td>
                            <td>$99/month</td>
                        </tr>
                        <tr>
                            <td><strong>Confidential Compute</strong></td>
                            <td>Hardware-encrypted VMs</td>
                            <td>$25/month</td>
                        </tr>
                        <tr>
                            <td><strong>Database Clusters</strong></td>
                            <td>Managed PostgreSQL, MySQL, Redis, MongoDB</td>
                            <td>$15/month</td>
                        </tr>
                        <tr>
                            <td><strong>Load Balancers</strong></td>
                            <td>High-availability load balancing</td>
                            <td>$10/month</td>
                        </tr>
                        <tr>
                            <td><strong>Block Storage</strong></td>
                            <td>Additional SSD storage volumes</td>
                            <td>$0.10/GB/month</td>
                        </tr>
                        <tr>
                            <td><strong>Object Storage</strong></td>
                            <td>S3-compatible object storage</td>
                            <td>$0.02/GB/month</td>
                        </tr>
                        <tr>
                            <td><strong>Snapshots</strong></td>
                            <td>VM and volume snapshots</td>
                            <td>$0.05/GB/month</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="stats-grid">
                    <div class="stat-card">
                        <i class="stat-card-icon fas fa-dollar-sign"></i>
                        <span class="stat-card-value">$0</span>
                        <span class="stat-card-label">Setup Fees</span>
                    </div>
                    <div class="stat-card">
                        <i class="stat-card-icon fas fa-clock"></i>
                        <span class="stat-card-value">Per-Second</span>
                        <span class="stat-card-label">Billing</span>
                    </div>
                    <div class="stat-card">
                        <i class="stat-card-icon fas fa-undo"></i>
                        <span class="stat-card-value">30 Days</span>
                        <span class="stat-card-label">Money Back</span>
                    </div>
                    <div class="stat-card">
                        <i class="stat-card-icon fas fa-headset"></i>
                        <span class="stat-card-value">24/7</span>
                        <span class="stat-card-label">Support</span>
                    </div>
                </div>
            </div>
        </section>
    `
};

// Export components
if (typeof module !== 'undefined' && module.exports) {
    module.exports = components;
}
