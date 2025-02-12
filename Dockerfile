# # 1️ Use the official Golang image as the base
# FROM golang:1.22.2

# # 2️ Set the working directory inside the container
# WORKDIR /app

# # 3️ Copy all files from the current directory to /app in the container
# COPY . .

# # 4️ Build the Go application
# RUN go build -o my-go-app

# # 5️ Set the command to run the compiled Go binary
# CMD ["./my-go-app"]


# FROM python:3.12.9-alpine3.21
# ADD . /app
# WORKDIR /app
# RUN pip install flask
# # COPY . /app
# EXPOSE 2004
# CMD ["python3", "demo.py"]


# Use the official Nginx image
FROM nginx:alpine

# Copy your HTML files to Nginx's default static content directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 (default for Nginx)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

