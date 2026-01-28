# 1. Use an official Python base image
FROM python:3.10-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set working directory inside container
WORKDIR /app

# 4. Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 5. Copy requirements
COPY requirements.txt /app/

# 6. Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 7. Copy project files
COPY . /app/

# 8. Expose port (Gunicorn will use 8000)
EXPOSE 8000

# 9. Run migrations at startup (optional but recommended)
CMD python manage.py migrate && \
    gunicorn onlinexam.wsgi:application --bind 0.0.0.0:8000