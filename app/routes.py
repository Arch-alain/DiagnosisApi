from flask import jsonify, request
from .detection.analysis import analyze_patient_slides
import json
import logging

logger = logging.getLogger(__name__)

def init_routes(app):
    @app.route('/diagnose', methods=['POST'])
    def diagnose():
        data = request.json
        image_paths = data.get('image_paths', [])
        if not image_paths:
            logger.warning("No image paths provided in request")
            return jsonify({"error": "No image paths provided"}), 400
        logger.info(f"Received request with {len(image_paths)} image paths")
        report = analyze_patient_slides(image_paths)
        return json.dumps(report, indent=2), 200, {'Content-Type': 'application/json'}