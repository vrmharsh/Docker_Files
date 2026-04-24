backend/
├── app/
│   ├── main.py              # entry point (FastAPI app)
│
│   ├── api/                 # route handlers
│   │   └── routes.py
│
│   ├── core/                # config + settings
│   │   └── config.py
│
│   ├── db/                  # DB connection layer
│   │   ├── session.py
│   │   └── base.py
│
│   ├── models/              # ORM models
│   │   └── user.py
│
│   ├── schemas/             # request/response validation
│   │   └── user_schema.py
│
│   ├── services/            # business logic
│   │   └── user_service.py
│
│   └── utils/               # helpers
│
├── requirements.txt
├── Dockerfile
├── .dockerignore
└── .env (local only, optional)



#stage-1: build

FROM python:3.11 AS build

WORKDIR /my-app

COPY requirements.txt /my-app

#Install dependencies without storing the cache files:
RUN pip install --no-cache-dir -r requirements.txt 

COPY . .

#stage-2: 

FROM python:3.11-alpine 

WORKDIR /my-app

COPY --from=build /my-app /my-app

EXPOSE 8000

CMD ["python", "app/main.py"]


## dokcer ignore will have .env and other file with any sensitive information
