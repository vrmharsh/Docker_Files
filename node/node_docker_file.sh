#node/
# └── portfolio-app/
#      ├── frontend/
#      └── backend/



# frontend_docker_file:

#stage-1: build stage

  FROM node:18.19.1 AS build

  WORKDIR /my-portfolio-app

  COPY package-lock.json package.json /my-portfolio-app/

  RUN npm install

  COPY . .

#stage-2:

  FROM node:18.19.1-alpine 

  WORKDIR /my-portfolio-app

  COPY --from=build /my-portfolio-app .

  EXPOSE 3000

  CMD ["npm","start"]


# backend_docker_file:

#stage-1:
  FROM node:18.19.1 AS build

  WORKDIR /my-portfolio-app

# They are Blueprint of dependencies, they define what packages you need exact versions (lock file)
  COPY package-lock.json package.json /my-portfolio-app/

# actual node_modules will be installed
  RUN  npm install

  COPY . .

#first dot means (local machine) backend/ folder
#Second dot means inside the container


#stage-2:
  FROM node:18.19.1-alpine

  WORKDIR /my-portfolio-app

  COPY --from=build /my-portfolio-app .


  EXPOSE 5000

  CMD ["node","index.js"]




# docker compose file:
services:
  frontend-app:
   image: "portfolio-app-frontend:latest"
   container_name: "frontend-container"
   networks:
    - my-networks
   ports:
    - "3000:3000"

  backend-app:
   image: "portfolio-app-backend:latest"
   container_name: "backend-container"
   ports:
    - "5000:5000"

   #environment:
   # - MYDATABASE={MYDATABASE}
   # - PORT={PORT}

   env_file:
    - ./backend/.env          #this path is as per the backend > env file in ny backend code present locally

   networks:
    - my-networks

networks:
  my-networks:


