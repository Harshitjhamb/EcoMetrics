# Deployment (Render + external MySQL + static frontend)

This guide deploys:
- **Backend** on Render (Flask via gunicorn)
- **Database** on a managed MySQL provider (recommended: Railway MySQL)
- **Frontend** on Netlify (or Render Static Site)

## 1) Create a MySQL database (recommended: Railway)

1. Create a new project → Add **MySQL**.
2. Copy connection values (host, port, user, password, database).
3. Import schema:

```bash
cd backend
mysql -h <host> -u <user> -p <db_name> < schema.sql
```

## 2) Push to GitHub

From the project root:

```bash
git init
git add .
git commit -m "Initial commit"
```

Create a new empty repo on GitHub (no README), then:

```bash
git branch -M main
git remote add origin https://github.com/<your-username>/<repo-name>.git
git push -u origin main
```

## 3) Deploy backend on Render

1. Render → **New** → **Web Service** → connect your GitHub repo.
2. Root Directory: `backend`
3. Build Command:
```bash
pip install -r requirements.txt
```
4. Start Command:
```bash
gunicorn wsgi:app --bind 0.0.0.0:$PORT
```

### Environment variables (Render → Environment)

Set:
- `DB_HOST`
- `DB_PORT`
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`
- `WEATHERAPI_KEY`
- `INDIA_DATA_API_KEY`
- `SECRET_KEY` (any long random string)
- `FLASK_DEBUG` = `false`

## 4) Hourly sync (Render Cron Job)

Render → **Cron Jobs** → create one with:

- Root Directory: `backend`
- Command:
```bash
python sync_once.py
```
- Schedule: `15 * * * *` (every hour at :15)

## 5) Deploy frontend (Netlify)

1. Netlify → New site from Git → select repo.
2. Base directory: `frontend`
3. Build command: *(none)*
4. Publish directory: `frontend`

Update `frontend/config.js` to your Render backend URL, e.g.:
```js
window.BACKEND_BASE = "https://your-render-service.onrender.com";
```

Commit and push—Netlify will redeploy automatically.

