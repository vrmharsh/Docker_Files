#Golang Docker Project

#Description:
This project contains a Golang application containerized using Docker with a multi-stage build approach to create a lightweight and secure image.

#Tech Stack
Golang
Docker
Alpine Linux

#Project Structure
.
├── Dockerfile
├── main.go
├── go.mod
├── go.sum
└── README.md

#Prerequisites:
Make sure you have installed:
Go
Docker

#Build Docker Image:
docker build -t golang-app .

#Run the Container
docker run -p 8080:8080 golang-app


#Key Features:
1. Multi-stage Docker build
2. Lightweight final image (Alpine)
3. Static Go binary (CGO_ENABLED=0)
4. Improved security (no source code in final image)

#Notes
Ensure your application runs on port 8080

#Author
Harsh Verma
