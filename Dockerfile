# 1. Use a specific version for reproducibility
FROM python:3.8-slim

# 2. Add metadata
LABEL Author="Ashutosh Kumar"
LABEL Project="Online Examination System"

# 3. Essential Python settings for Docker
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 4. Set working directory (absolute path is safer)
WORKDIR /app

# 5. Install dependencies first (leverages Docker cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the code
COPY . .

# 7. Expose the port (documentation only)
EXPOSE 8000

# 8. Corrected CMD to listen on all interfaces
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
