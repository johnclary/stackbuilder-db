# stackbuilder-db

## Local dev

1. Start the cluster

```shell
$ docker-compose up -d
$ hasura console
```

2. Apply metadata to connect to db

```shell
# establishes db conn
$ hasura metadata apply
```

3. run migrations and seeds

```shell
$ hasura migrate apply
$ hasura seed apply
# reapply metadata to clear inconsistent
$ hasura metadata apply
```

# apply to prod

This has to be done manually :)

```shell
$ hasura migrate apply --envfile production.env
$ hasura metadata apply --envfile production.env
```
