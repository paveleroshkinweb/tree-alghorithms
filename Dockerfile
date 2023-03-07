ARG VERSION=3.10.0-slim

FROM python:$VERSION
LABEL maintainer="paveleroshkinweb"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# create separate user as good practice to avoid using root user
RUN adduser app --home /home/app --shell /bin/bash --disabled-password
USER app
WORKDIR /home/app

# install python project dependencies
RUN pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Expect src/ and tests/ to be volume mounts
CMD ["python", "-m", "pytest", "-v", "tests"]
