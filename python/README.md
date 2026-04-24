# Dockerized Python Backend (FastAPI / Flask)

## Overview

This project demonstrates containerizing a **Python backend application** using Docker.

It focuses on:

* Efficient Docker layering
* Dependency management using `requirements.txt`
* Clean runtime execution inside containers

---

## Tech Stack

* Python 3.x
* FastAPI / Flask
* Docker

---

## Project Structure

```bash
backend/
├── app/                     # Application source code
│   └── main.py             # Entry point
├── requirements.txt        # Python dependencies
├── Dockerfile              # Container definition
├── .dockerignore
└── README.md
```

---

## Key Concepts Covered

* **Layer optimization**

  * Copying `requirements.txt` first for caching

* **Dependency installation**

  * Using `pip install --no-cache-dir` to reduce image size

* **Containerized execution**

  * Running application via `CMD`

* **Separation of concerns**

  * Code, configuration, and runtime clearly separated

---

##  Build & Run

### 1. Build Docker Image

```bash
docker build -t python-backend .
```

---

### 2. Run Container

```bash
docker run -p 8000:8000 python-backend
```

---

### 3. Access Application

```
http://localhost:8000
```

---

##  Environment Variables

Environment variables can be passed using:

```bash
docker run --env-file .env python-backend
```

Example:

```
DB_HOST=db
DB_PORT=5432
DB_NAME=mydb
DB_USER=postgres
DB_PASSWORD=postgres
```

---

## Notes

* Ensure the application binds to `0.0.0.0` inside the container
* Avoid hardcoding secrets inside the Dockerfile
* `.dockerignore` should exclude unnecessary files like:

  * `__pycache__/`
  * `.env`
  * `.git/`

---

## Conclusion

This setup provides a **clean and scalable approach** to containerizing Python backend applications, aligned with real-world DevOps practices.
