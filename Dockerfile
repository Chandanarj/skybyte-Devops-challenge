# Use a small, fixed Python image (no latest)
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy only requirements first (better caching)
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app/ .

# Create non-root user
RUN useradd -m appuser

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 80

# Run application
CMD ["python", "main.py"]