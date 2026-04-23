# EcoMetrics

EcoMetrics is a Flask (Python) backend + static HTML/JS frontend for environmental/air-quality and weather dashboards.

## Local run

### Backend (Flask)
```bash
cd backend
cp .env.example .env   # fill values
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

### Frontend (static)
```bash
cd frontend
python -m http.server 5173
```
Open: http://127.0.0.1:5173

## Configuration

Frontend backend URL is set in `frontend/config.js`.

## Database

Create tables using:
```bash
cd backend
mysql -h <host> -u <user> -p <db_name> < schema.sql
```

## Deploy (recommended)

See `DEPLOYMENT.md`.

