FROM node:8

WORKDIR /app
COPY . .

RUN yarn install
RUN yarn global add nyc@11.4.1


RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 >> ./cc-test-reporter
RUN chmod +x ./cc-test-reporter

RUN ./cc-test-reporter before-build
ENV CC_TEST_REPORTER_ID=dcff493bb0cdc31165264afad995af8ba606169be1f312be7b68b39f7d10c16c
RUN nyc --reporter=lcov yarn run unit
RUN ./cc-test-reporter after-build --exit-code $?
