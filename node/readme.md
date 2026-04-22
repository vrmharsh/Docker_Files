#  Dockerized Portfolio App

##  Overview

This project is a dockerized version of full-stack  application.
It demonstrates containerizing frontend and backend services using Docker and orchestrating them using Docker Compose.

---

##  Architecture

Frontend (React) → Backend (Node.js/Express) → MongoDB Atlas
All services communicate over a Docker network.

---

##  Tech Stack

* React
* Node.js
* Express
* MongoDB Atlas
* Docker
* Docker Compose

---

##  Features

* Multi-container setup using Docker Compose
* Frontend & backend containerization
* Environment variable management
* Container networking (service-to-service communication)
* MongoDB Atlas integration
* Optimized Docker images using multi-stage builds

---

##  Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/vrmharsh/dockerized-portfolio-app.git
cd dockerized-portfolio-app
```

---

### 2. Setup environment variables

Create `.env` file inside backend:

```bash
cp backend/.env.example backend/.env
```

Add your MongoDB connection string:

```env
MYDATABASE=your_mongodb_connection_string
PORT=5000
```

---

### 3. Build and run containers

```bash
docker compose up --build
```

---

##  Access Application

* Frontend → http://localhost:3000
* Backend → http://localhost:5000

---

##  Container Communication

Inside Docker network:

* Frontend should call backend using:

  ```
  http://backend-container:5000
  ```
* Do NOT use `localhost` inside containers.

---

##  Project Structure

```
.
├── backend/
│   ├── models/
│   ├── router/
│   ├── database/
│   ├── index.js
│   ├── Dockerfile
│   └── .env (ignored)
├── public/
├── src/
├── docker-compose.yml
├── Dockerfile
└── README.md
```

---

##  Key Learnings

* Dockerizing full-stack applications
* Managing multi-container environments
* Debugging container networking issues
* Handling environment variables securely
* Optimizing Docker images

---

##  Notes

* `.env` file is ignored via `.gitignore` and `.dockerignore`
* Ensure MongoDB Atlas IP access is configured
* Do not commit sensitive credentials

---

## Author

Harsh
