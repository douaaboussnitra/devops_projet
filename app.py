import signal  # ← ADD THIS IMPORT
import sys     # ← ADD THIS IMPORT
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({'message': 'DevOps App DSBD', 'status': 'okk'})

@app.route('/health')
def health():
    return jsonify({'status': 'ok'}), 200

# ADD THIS FUNCTION ↓↓↓
def graceful_shutdown(signum, frame):
    print(f"Received signal {signum}, shutting down gracefully...")
    sys.exit(0)

# ADD THESE LINES ↓↓↓
signal.signal(signal.SIGTERM, graceful_shutdown)
signal.signal(signal.SIGINT, graceful_shutdown)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False) 
