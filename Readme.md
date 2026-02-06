# Fullstack Django & React Boilerplate (Dockerized)

This repository provides a production-ready architecture for a fullstack application featuring a **Django REST Framework** backend, a **React** frontend, and a **PostgreSQL** database.

The entire workflow—from local development to production deployment—is streamlined through **Docker Compose** and automated via a **Makefile**.

## 🚀 Technologies
* **Backend:** Django REST Framework (Python)
* **Frontend:** React (JavaScript/TypeScript)
* **Database:** PostgreSQL
* **Orchestration:** Docker Compose
* **Automation:** GNU Makefile

---

## 🛠️ Getting Started

### Prerequisites
* [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
* [Make](https://www.gnu.org/software/make/)

### Installation & Setup
To initialize the project for the first time (build images, run migrations, and create a superuser), simply run:
```bash
make setup