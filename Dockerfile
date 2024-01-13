FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y nginx curl

EXPOSE 8000

COPY ./nginx/nginx.conf /etc/nginx/conf.d/

RUN ln -s /etc/nginx/conf.d/nginx.conf /etc/nginx/sites-enabled/

# v1
# RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.13.0-amd64.deb && \
#     dpkg -i filebeat-7.13.0-amd64.deb

# COPY ./ngix/filebeat.yml /etc/filebeat/filebeat.yml    
# COPY ./ngix/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT [ "/entrypoint.sh" ]
# end v1

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "elasticode.wsgi:application"]


# docker compose up --build