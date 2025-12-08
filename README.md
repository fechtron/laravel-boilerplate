# laravel-boilerplate
Laravel project boilerplate using docker containers

## Create a empty project
Run the script: `./create-project.sh`

# Permission

Run on project root folder:

`sudo chown -R $(whoami):www-data ./app`
`sudo chmod -R 777 ./app`


sudo chown -R $USER:$USER .


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

---

# Autenticação

## Breeze
Cria toda uma estrutura básica de autenticação, com tela de login, registro e inclusive um dashboard.
É muito bom se quer rapidez e algo pronto, mas é ruim se quiser alterar o layouts das páginas.

## Fortify
É uma implementação de backend para autenticação.
É agnóstica em relação ao frondend. Pode criar para qualquer layout.
Permite criar rapidamente as lógicas de login, logout, password reset, verificação de e-mail, 2FA, atualização de perfil etc.

---

# Email

php artisan make:mail NewUserConfirmation


--- 

# Aula 11
Exemplo com breeze


Your Composer dependencies require a PHP version ">= 8.4.0". You are running 8.2.29. in

No composer lock substituir
"php": ">=8.4"

por 
"php": ">=8.2"

---

Instalar o breeze
composer require laravel/breeze --dev
php artisan breeze:install


Instalar e rodar npm
apt-get install npm
npm install

atualizar vite.config.js para:
```
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    server: {
        host: true,
        port: 5173,
        strictPort: true,
    },
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
});
```

npm run dev

acessar: http://172.19.0.3:5173/

