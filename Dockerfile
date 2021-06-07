FROM python:3-alpine3.11

RUN apk add --update --no-cache gcc musl-dev postgresql-dev postgresql-libs postgresql-client=~12
RUN pip3 install requests psycopg2 tabulate

ADD sync /app/sync

WORKDIR /app
CMD python3 sync
