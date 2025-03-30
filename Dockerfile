# Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ ./app/
COPY app/models/best.pt ./models/best.pt
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser
EXPOSE 5000
RUN mkdir -p /app/logs && chown appuser:appuser /app/logs
CMD ["python", "-m", "app"]