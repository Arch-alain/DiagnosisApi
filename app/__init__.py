from flask import Flask
from .utils.logging import setup_logging
from .routes import init_routes

def create_app():
    app = Flask(__name__)
    setup_logging()  # Configure logging
    init_routes(app)  # Register routes
    return app

# app = create_app()