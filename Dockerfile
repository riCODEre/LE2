# syntax=docker/dockerfile:1
FROM python:3.13-alpine
WORKDIR /code
RUN apk update \
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add --no-cache mariadb-dev
RUN pip install django mysqlclient
RUN apk del build-deps
EXPOSE 8000
COPY . .
RUN python manage.py migrate
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
