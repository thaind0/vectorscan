# Use a Rust base image
FROM rust:latest AS builder

# Set the working directory
WORKDIR /app

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    ragel \
    && apt-get clean 

# Copy the project files into the container
COPY . .

# Build the project
RUN cargo build --release