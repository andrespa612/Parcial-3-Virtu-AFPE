# API
FROM python:3.9-slim AS api

WORKDIR /api

RUN pip install flask pymysql cryptography

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]

