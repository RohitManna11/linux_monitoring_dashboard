# **📌 Linux Monitoring Dashboard**

A **real-time monitoring solution** for Linux using **Prometheus, Grafana, and Alertmanager** to track system metrics and send alerts.

---

## **🚀 Features**

✅ **Monitor CPU, Memory, Disk, and Network usage**

✅ **Real-time visualization in Grafana**

✅ **Alerting via Slack or Email when thresholds exceed**

---

## **📂 Setup Instructions**

### **1️⃣ Install Prometheus**

```bash
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-*.linux-amd64.tar.gz
tar xvfz prometheus-*.linux-amd64.tar.gz
cd prometheus-*.linux-amd64
./prometheus --config.file=prometheus.yml &
```

### **2️⃣ Install Node Exporter**

```bash
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-*.linux-amd64.tar.gz
tar xvfz node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.linux-amd64
./node_exporter &
```

### **3️⃣ Install Alertmanager**

```bash
wget https://github.com/prometheus/alertmanager/releases/latest/download/alertmanager-*.linux-amd64.tar.gz
tar xvfz alertmanager-*.linux-amd64.tar.gz
cd alertmanager-*.linux-amd64
./alertmanager --config.file=alertmanager.yml &
```

---

## **🛠 Configuration Files**

### **📌 Prometheus Configuration (`prometheus.yml`)**

```yaml
# my global config
global:
  scrape_interval: 5s
  evaluation_interval: 15s

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           - "localhost:9093"

# Load alert rules
rule_files:
   - "alert.rules.yml"

scrape_configs:
  - job_name: "linux-monitoring"
    static_configs:
      - targets: ["localhost:9100"]
```

---

### **📌 Alertmanager Configuration (`alertmanager.yml`)**

```yaml
global:
  resolve_timeout: 5m

route:
  receiver: 'slack-alert'

receivers:
  - name: 'slack-alert'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/your/slack/webhook'
        channel: '#alerts'
        send_resolved: true
```

---

### **📌 Alert Rules (`alert.rules.yml`)**

```yaml
groups:
  - name: linux-alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100) > 80
        for: 10s
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on instance {{ $labels.instance }}"
          description: "CPU usage is above 80% for the last minute. Current value: {{ $value }}%."

      - alert: HighMemoryUsage
        expr: (node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100 > 80
        for: 10s
        labels:
          severity: warning
        annotations:
          summary: "High memory usage detected on instance {{ $labels.instance }}"
          description: "Memory usage is above 90% for the last minute. Current value: {{ $value }}%."
```

---

## **🎯 Running the System Monitoring Script**

1. Clone this repository:
    
    ```bash
    git clone https://github.com/RohitManna11/linux_monitoring_dashboard.git
    cd linux_monitoring_dashboard  
    ```
    
2. Run the **`system_stats.sh`** script:
    
    ```bash
    bash system_stats.sh  
    ```
    

---

## **📊 View Metrics in Grafana**

1. Install Grafana:
    
    ```bash
    sudo apt install grafana
    ```
    
2. Start Grafana:
    
    ```bash
    sudo systemctl start grafana-server 
    ```
    
3. Open **Grafana UI** at `http://localhost:3000/`
4. Add **Prometheus as a data source** and use the **Node Exporter Dashboard (ID: 1860)**.
