FROM node:14

ENV MONGODB_HOST=mongo
ENV MONGODB_DB=notesdb
ENV PORT=4000

LABEL author="riya"

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 4000

CMD [ "npm", "run", "dev" ]