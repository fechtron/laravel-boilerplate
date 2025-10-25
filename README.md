# laravel-boilerplate
Laravel project boilerplate using docker containers

## Create a empty project
Run the script: `./create-project.sh`

# Permission

Run on project root folder:

`sudo chown -R $(whoami):www-data ./app`
`sudo chmod -R 777 ./app`


# Add XDEBUG

- create:

php/conf.d/xdebug.ini

```
; Xdebug 3 - config mínima útil para debugging com VSCode
zend_extension=xdebug

xdebug.mode=debug
; start_with_request = yes -> sempre inicia; "trigger" -> só quando enviar XDEBUG_TRIGGER (mais controlado)
xdebug.start_with_request=yes

; porta padrão do xdebug 3
xdebug.client_port=9003

; defina o host do cliente (onde o VSCode está rodando)
; Em Docker Desktop / macOS / Windows: host.docker.internal funciona.
xdebug.client_host=host.docker.internal

; opcional: log para debug se tiver problema
xdebug.log=/tmp/xdebug.log
xdebug.log_level=0
```

- Add to docker-compose

```
    ...
    volumes:
      - ./app:/var/www/html
      - ./app/storage:/var/www/html/storage
      - ./app/database:/var/www/html/database
      - ./php/conf.d/xdebug.ini:/usr/local/etc/php/conf.d/xdebug.ini
    ports:
      - "9000:9000"   # se PHP-FPM estiver nesta porta (opcional)
      - "9003:9003"   # porta Xdebug (expõe para host)
    extra_hosts:
      - "host.docker.internal:host-gateway"
    environment:
      XDEBUG_MODE: debug
      XDEBUG_CLIENT_HOST: host.docker.internal
      XDEBUG_CLIENT_PORT: 9003
```

- Dockerfile

```
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
```

Check if xdebug is enabled

`docker-compose exec app bash`
`php -v`

you should see: "With XDebug..."


- Configure vscode

.vscode/launch.json

```JSON
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for Xdebug",
      "type": "php",
      "request": "launch",
      "port": 9003,
      "pathMappings": {
        "/var/www/html": "${workspaceFolder}"
      },
      "ignore": ["**/vendor/**/*.php"]
    }
  ]
}

```


listen EADDRINUSE:address already in use 9003
sudo lsof -i :9003
sudo kill -9 <PID>

