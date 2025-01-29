FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

# Install system dependencies and clean up to reduce image size
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

# Set default command to run migrations and start the server
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]

