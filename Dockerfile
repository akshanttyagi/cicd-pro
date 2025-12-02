# Use a small Python base
FROM python:3.11-slim

# Set working dir
WORKDIR /app

# Copy files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Expose port
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]
