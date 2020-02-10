# First we create a container that copies all source files 
# then runs the build process
FROM mhart/alpine-node  AS builder
WORKDIR /app
COPY . .
RUN yarn run build

# Then we create our container that will serve the react app
FROM mhart/alpine-node
RUN yarn global add serve
WORKDIR /app
COPY --from=builder /app/build .
CMD [ "serve", "-p", "80", "-s", "." ]

