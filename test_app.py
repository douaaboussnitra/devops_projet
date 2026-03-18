from app import app

def test_home():
    c = app.test_client()
    assert c.get('/').status_code == 200

def test_health():
    c = app.test_client()
    assert c.get('/health').status_code == 200
