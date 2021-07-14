FROM python:3-alpine3.11

RUN apk add --update --no-cache gcc=9.3.0-r0               \
                                musl-dev=1.1.24-r3         \
                                postgresql-dev=12.7-r0     \
                                postgresql-libs=12.7-r0    \
                                postgresql-client=12.7-r0

RUN pip3 install requests==2.25.1  \
                 psycopg2==2.8.6   \
                 tabulate==0.8.9

ADD sync /app/sync

WORKDIR /app
CMD python3 sync
