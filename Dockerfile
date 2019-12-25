FROM node:8

#Create Working Directory
WORKDIR /app

#Copy all necessary files
COPY . .

#Install necessary packages
RUN yarn install

#Install specific version of nyc
RUN yarn global add nyc@11.4.1

#Download code climate
RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 >> ./cc-test-reporter

#Change permission of code climate test reporter for execution
RUN chmod +x ./cc-test-reporter

RUN ./cc-test-reporter before-build

#Code Climate Test Reporter ID
ENV CC_TEST_REPORTER_ID=dcff493bb0cdc31165264afad995af8ba606169be1f312be7b68b39f7d10c16c

#Run test
RUN nyc --reporter=lcov yarn run unit

#Upload test report to specific reporter ID
RUN ./cc-test-reporter after-build --exit-code $?

