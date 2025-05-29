# Use the slim Python image as a base
FROM python:3.11-slim

# Update and install PostgreSQL client
RUN apt update && apt install -y postgresql-client \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /usr/app

# Copy requirements file to the container
COPY requirements.txt .

# Install dependencies
RUN  pip install --upgrade pip &&  pip install -r requirements.txt