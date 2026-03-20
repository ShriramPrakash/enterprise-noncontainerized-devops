from importlib import util
from pathlib import Path

app_file = Path(__file__).resolve().parents[1] / "src" / "app.py"
spec = util.spec_from_file_location("webapp", app_file)
module = util.module_from_spec(spec)
spec.loader.exec_module(module)

app = module.app

def test_home():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200

def test_health():
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
