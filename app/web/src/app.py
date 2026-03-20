from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    version = "unknown"
    try:
        with open("/opt/company/web/current/version.txt", "r", encoding="utf-8") as f:
            version = f.read().strip()
    except Exception:
        pass
    return f"Hello from enterprise web app. Version={version}"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", "5000"))
    app.run(host="0.0.0.0", port=port)
