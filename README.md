## **📌 Linux Monitoring Dashboard**

A lightweight **Linux system monitoring solution** using **Prometheus, Grafana, and Alertmanager** to track CPU, Memory, and Network usage.

### **🚀 Features**

✅ Collects **CPU, Memory, Disk, and Network stats**

✅ Alerts via **Slack & Email** when usage exceeds thresholds

✅ Uses **Prometheus + Grafana for real-time visualization**

---

### **📂 Setup Instructions**

### **1️⃣ Install Prometheus**

```bash
bash
CopyEdit
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-*.linux-amd64.tar.gz
tar xvfz prometheus-*.linux-amd64.tar.gz
cd prometheus-*.linux-amd64

```

### **2️⃣ Install Node Exporter**

```bash
bash
CopyEdit
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-*.linux-amd64.tar.gz
tar xvfz node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.linux-amd64

```

Run:

```bash
bash
CopyEdit
./node_exporter &

```

### **3️⃣ Install Alertmanager**

```bash
bash
CopyEdit
wget https://github.com/prometheus/alertmanager/releases/latest/download/alertmanager-*.linux-amd64.tar.gz
tar xvfz alertmanager-*.linux-amd64.tar.gz
cd alertmanager-*.linux-amd64
./alertmanager --config.file=alertmanager.yml &

```

---

### **🛠 Running the System Monitoring Script**

1. Clone this repository:
    
    ```bash
    bash
    CopyEdit
    git clone https://github.com/RohitManna11/linux_monitoring_dashboard.git
    cd linux_monitoring_dashboard
    
    ```
    
2. Run the **`system_stats.sh`** script:
    
    ```bash
    bash
    CopyEdit
    bash system_stats.sh
    
    ```
    

---

### **📊 View Metrics in Grafana**

1. Install Grafana:
    
    ```bash
    bash
    CopyEdit
    sudo apt install grafana
    
    ```
    
2. Start Grafana:
    
    ```bash
    bash
    CopyEdit
    sudo systemctl start grafana-server
    
    ```
    
3. Open **Grafana UI** at `http://localhost:3000/`
4. Add **Prometheus as a data source** and use the **Node Exporter Dashboard (ID: 1860)**.

---

### **📢 Alerting with Slack**

Configure alerts in `alertmanager.yml`:

```yaml
yaml
CopyEdit
route:
  receiver: 'slack-alert'

receivers:
  - name: 'slack-alert'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
        channel: '#alerts'

```

Restart Alertmanager to apply changes:

```bash
bash
CopyEdit
pkill alertmanager
./alertmanager --config.file=alertmanager.yml &

```
