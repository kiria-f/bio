FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY pubspec.yaml ./
RUN flutter config --enable-web
RUN flutter pub get
COPY web/ web/
COPY assets/ assets/
COPY lib/ lib/
RUN flutter build web


FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html
