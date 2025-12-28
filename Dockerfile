# Stage 1: Build the static site
FROM node:lts-alpine as builder

# Install Hugo (extended version for better theme support)
RUN apk add --no-cache hugo

WORKDIR /app
COPY . .

# Run the build (creates /public directory)
RUN hugo --minify

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the build output from Stage 1 to Nginx
COPY --from=builder /app/public /usr/share/nginx/html

# Default Nginx port
EXPOSE 80