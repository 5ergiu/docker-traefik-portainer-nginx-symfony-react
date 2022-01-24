<p align="center"><img src="https://miro.medium.com/max/1400/1*i0eA090ppYCs3-fzPjkzOA.png" width="350"></p>
<p align="center">
   <a href="https://www.docker.com" target="_blank">Docker</a>
   based project with
   <a href="https://github.com/traefik/traefik#readme" target="_blank">Traefik</a>
   used as a reverse proxy for 
   <a href="https://github.com/symfony/symfony#readme" target="_blank">Symfony</a>
   ♥️
   <a href="https://github.com/facebook/react#readme" target="_blank">React</a>
</p>

Contents
========

* [Tech stack](#tech-stack)
* [Installation](#installation)
* [Configuration](#configuration)
* [Release notes](#release-notes)
* [Scripts](#scripts)
* [Development](#development)

### Tech stack

| Stack           | Technology                                                                                                                                                                        |
|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 🛠️ Environment | Docker                                                                                                                                                                            |
| 💻 Backend      | PHP 8.1 (with [OPcache](https://devdojo.com/bobbyiliev/how-to-speed-up-your-laravel-application-with-php-opcache) & [JIT compiler](https://kinsta.com/blog/php-8/#jit)) - Symfony |
| 🌐 Frontend     | React - TypeScript - SASS                                                                                                                                                         |
| 🛢 Database     | MySQL 8                                                                                                                                                                           |
| 🗄️ Server      | Nginx                                                                                                                                                                             |

### Installation

To get started, make sure you have [Docker](https://docs.docker.com/desktop/#download-and-install) && [Docker compose](https://docs.docker.com/compose/install)
installed on your system, and then clone this repository.

1. Update hosts:
   ```
   127.0.0.1 mysite.local
   127.0.0.1 www.mysite.local
   127.0.0.1 api.mysite.local
   127.0.0.1 traefik.mysite.local
   127.0.0.1 portainer.mysite.local
   ```

2. Run `./scripts/install.sh` to install the project

***That's it!*** The website is up and running:
- http://mysite.local
- http://www.mysite.local
- http://api.mysite.local
- http://traefik.mysite.local
- http://portainer.mysite.local

### Configuration

The configuration is mostly controlled through environment variables.
There are the usual env variables used by Symfony and some used to configure Docker and PHP.
More info on each of the variables and their roles can be found in the default env file - **.env.default**.

Also, there are 2 docker-compose files, the **docker-compose.dev.yml** file is used for local development, whilst
the other one is used for prod environment.

### Scripts

Scripts to ease development:

1. **./scripts/install.sh** : Installs the project (can be used for dev && PROD)

### Release Notes

1. Pull code from main git repo
2. If necessary:
    1. Run migrations *(in project root)* : **docker-compose exec -it backend php artisan migrate**
    2. Install new dependencies *(in project root)* : **docker-compose exec -it backend composer install**
    3. Build frontend assets *(in project root)* : **docker-compose exec -it frontend yarn build**
    4. Restart/rebuild docker images/containers

### Development

* Each feature/task/issue is developed on a separate branch
* [SOLID](https://geekflare.com/php-solid-principles/)
* [Mobile first design](https://medium.com/@Vincentxia77/what-is-mobile-first-design-why-its-important-how-to-make-it-7d3cf2e29d00)
* [BEM methodology for CSS](https://en.bem.info/methodology/)
* Translations ordered alphabetically for ease of use
