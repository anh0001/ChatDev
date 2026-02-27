# ChatDev Setup Instructions

## Overview
ChatDev has been installed on your Ubuntu 22.04 system using a conda environment to keep Python 3.12 isolated from your system Python 3.10 (needed for ROS 2 Humble).

## Installation Summary

✅ **Completed Steps:**
1. Python 3.12 installed via conda environment `chatdev`
2. Node.js v20.19.4 (already installed)
3. uv package manager installed
4. ChatDev cloned to `~/codes/ChatDev`
5. Python dependencies installed via `uv sync`
6. Frontend dependencies installed via `npm install`
7. `.env` configuration file created

## Directory Structure
```
~/codes/ChatDev/
├── .env                  # Configuration file for Ollama connection
├── start_chatdev.sh      # Quick start script
├── frontend/             # React frontend
├── server_main.py        # Backend server
└── ...
```

## Configuration

### Connect to Remote Ollama

Edit `~/codes/ChatDev/.env` and update the `BASE_URL`:

```bash
nano ~/codes/ChatDev/.env
```

Change:
```ini
BASE_URL=http://localhost:11434/v1
```

To your remote Ollama server:
```ini
BASE_URL=http://<YOUR_OLLAMA_HOST_OR_IP>:11434/v1
```

Example:
```ini
BASE_URL=http://192.168.1.100:11434/v1
```

### Verify Remote Ollama Connection

Test connectivity from your Ubuntu machine:
```bash
curl -s http://<YOUR_OLLAMA_HOST_OR_IP>:11434/v1/models | head
```

**Important:** Your remote Ollama must:
- Bind to `0.0.0.0` (not just localhost)
- Have port 11434 open in firewall
- Be accessible from this machine

## Running ChatDev

### Option 1: Quick Start (Recommended)
```bash
cd ~/codes/ChatDev
./start_chatdev.sh
```

This will:
- Activate the `chatdev` conda environment
- Start both backend and frontend servers
- Backend: http://localhost:6400
- Frontend: http://localhost:5173

### Option 2: Manual Start

**Terminal 1 - Backend:**
```bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate chatdev
cd ~/codes/ChatDev
uv run python server_main.py --port 6400 --reload
```

**Terminal 2 - Frontend:**
```bash
cd ~/codes/ChatDev/frontend
VITE_API_BASE_URL=http://localhost:6400 npm run dev
```

### Option 3: Using Make
```bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate chatdev
cd ~/codes/ChatDev
make dev
```

## Usage

Once both servers are running:
1. Open your browser to **http://localhost:5173**
2. ChatDev UI should load
3. Start creating software projects!

Press `Ctrl+C` to stop the servers.

## Troubleshooting

### Cannot connect to Ollama
- Verify Ollama is running on remote machine
- Check network connectivity: `ping <OLLAMA_HOST>`
- Verify port 11434 is open: `telnet <OLLAMA_HOST> 11434`
- Check `.env` file has correct BASE_URL

### Python version issues
- Make sure you're in the conda environment: `conda activate chatdev`
- Check Python version: `python --version` (should be 3.12.12)

### Frontend won't start
- Make sure Node.js is installed: `node --version`
- Reinstall frontend deps: `cd ~/codes/ChatDev/frontend && npm install`

### Backend won't start
- Check conda environment: `conda activate chatdev`
- Reinstall Python deps: `cd ~/codes/ChatDev && uv sync`

## System Python Preserved

Your system Python 3.10 remains untouched for ROS 2 Humble:
```bash
python3 --version  # Still 3.10.12
```

ChatDev uses Python 3.12 only within the `chatdev` conda environment.

## Deactivating Environment

When you're done with ChatDev:
```bash
conda deactivate
```

## Updating ChatDev

```bash
cd ~/codes/ChatDev
git pull
source ~/miniconda3/etc/profile.d/conda.sh
conda activate chatdev
uv sync
cd frontend && npm install && cd ..
```

## Additional Resources
- ChatDev GitHub: https://github.com/OpenBMB/ChatDev
- Ollama Documentation: https://docs.ollama.com/
- ChatDev Documentation: Check the main README.md
