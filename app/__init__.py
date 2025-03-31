# from flask import Flask
# from .utils.logging import setup_logging
# from .routes import init_routes

# def create_app():
#     app = Flask(__name__)
#     setup_logging()  # Configure logging
#     init_routes(app)  # Register routes
#     return app

# app = create_app()

from flask import Flask

app = Flask(__name__)

from app.routes import init_routes # Import routes after initializing Flask
init_routes(app)