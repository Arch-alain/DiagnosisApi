# Use official Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libpq-dev \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create necessary directories with appropriate permissions
RUN mkdir -p /app/logs /app/uploads \
    && chown -R nobody:nogroup /app/logs /app/uploads \
    && chmod -R 755 /app/logs /app/uploads

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    FLASK_ENV=production \
    YOLO_CONFIG_DIR=/app/config

# Expose port
EXPOSE 5000

# Run the app
CMD ["python", "run.py"]
