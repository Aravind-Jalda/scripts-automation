# Elasticsearch 8 Installation & Cleanup Script (Ubuntu)

## 📌 Overview

This project provides a Bash script to:

* Remove any existing Elasticsearch installations
* Clean up leftover configuration and data
* Install Elasticsearch 8.x from the official repository
* Start and verify the Elasticsearch service

---

## ⚙️ Prerequisites

* Ubuntu OS (18.04 / 20.04 / 22.04)
* Sudo privileges
* Internet access
* `curl` installed

---

## 📂 Project Structure

```
elasticsearch-setup/
├── install_elasticsearch.sh
├── README.md
```

---

## 🚀 Usage

### 1. Make Script Executable

```bash
chmod +x install_elasticsearch.sh
```

### 2. Run the Script

```bash
./install_elasticsearch.sh
```

---

## 🔧 What the Script Does

### 1. Cleanup

* Stops Elasticsearch service (if running)
* Removes existing Elasticsearch packages
* Deletes leftover directories:

  * `/etc/elasticsearch`
  * `/var/lib/elasticsearch`
  * `/var/log/elasticsearch`

---

### 2. Installation

* Installs required dependencies
* Adds Elasticsearch GPG key
* Adds official Elasticsearch 8.x repository
* Installs Elasticsearch package

---

### 3. Service Setup

* Enables Elasticsearch service
* Starts the service
* Checks service status

---

### 4. Verification

* Runs:

```bash
curl http://localhost:9200
```

* Confirms Elasticsearch is running

---

## 🔐 Security Notes

* Elasticsearch 8.x enables security by default
* Access may require authentication
* Default configuration binds to localhost

---

## ⚠️ Important Considerations

* This script **removes all existing Elasticsearch data**
* Use only in:

  * Development environments
  * Fresh setups
* For production:

  * Take backups before removal
  * Plan upgrade strategy carefully

---

## 🛠️ Optional Configuration

Edit configuration file:

```bash
sudo vi /etc/elasticsearch/elasticsearch.yml
```

Example:

```
network.host: 0.0.0.0
```

> ⚠️ Exposing to public network without security is unsafe

---

