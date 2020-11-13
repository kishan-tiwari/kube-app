FROM node:8-alpine
WORKDIR /usr/share/app
COPY . .
RUN npm ci
EXPOSE 4000

HEALTHCHECK --interval=12s --timeout=12s --start-period=30s \  
 CMD node ./healthcheck.js

CMD ["npm", "start"]

