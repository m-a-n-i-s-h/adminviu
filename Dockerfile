FROM node:8

WORKDIR /app
COPY . .

RUN yarn install
RUN yarn add nyc
#RUN  nyc --reporter=lcov yarn run unit

RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 >> ./cc-test-reporter
RUN chmod +x ./cc-test-reporter

ENV CODECLIMATE_REPO_TOKEN=272f3f8a1ce56012378d71f22f52b1f34fe1499debe7943fe1cd0398bf808aa7
RUN ./cc-test-reporter before-build
RUN nyc --reporter=lcov yarn run unit
RUN ./cc-test-reporter after-build --exit-code $?
