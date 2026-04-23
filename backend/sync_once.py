"""
Run a single external-data sync and exit.
Use this for Render Cron Jobs (or any scheduler) instead of fetch.py,
which is an infinite loop.
"""

from app import sync_external_data
if __name__ == "__main__":
    sync_external_data()

