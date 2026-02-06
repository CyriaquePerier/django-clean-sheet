# --- Common base ---
FROM python:3.14-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

COPY requirements ./requirements
RUN pip install --upgrade pip && pip install -r requirements/prod.txt

COPY ./app .


# --- Stage local dev ---
FROM base AS dev

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# --- Stage prod ---
FROM base AS prod

RUN useradd -m backend-user
USER backend-user


EXPOSE 8000

CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]