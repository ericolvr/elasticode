FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y nginx

EXPOSE 8000

COPY ./nginx/nginx.conf /etc/nginx/conf.d/

RUN ln -s /etc/nginx/conf.d/nginx.conf /etc/nginx/sites-enabled/

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "elasticode.wsgi:application"]


# docker compose up --build