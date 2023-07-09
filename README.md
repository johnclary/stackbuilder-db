# stackbuilder-db

## Local dev

```shell
$ docker-compose up -d
$ hasura console
```

# apply to prod

This has to be done manually :)

```shell
$ hasura migrate apply --envfile production.env        
$ hasura metadata apply --envfile production.env
```
