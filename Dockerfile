FROM python:3.11-slim

WORKDIR /app

# Install minimal system dependencies (uvloop removed)
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install Python dependencies (no build tools needed now)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port (Railway uses this)
EXPOSE ${PORT:-8080}

# Run the application
CMD ["python3", "main.py"]