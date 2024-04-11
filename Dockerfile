FROM python:3-alpine3.11

RUN apk add --update --no-cache gcc=9.3.0-r0               \
                                musl-dev=1.1.24-r3         \
                                postgresql-dev=~12       \
                                postgresql-libs=~12      \
                                postgresql-client=~12

RUN pip3 install psycopg2==2.8.6   \
                 tabulate==0.8.9

ADD query_runner /app/query_runner

WORKDIR /app
CMD python3 query_runner
