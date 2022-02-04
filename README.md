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
<p align="center">
<a href="https://github.com/tjackenpacken/taskbar-groups/issues"><img alt="Issues open" src="https://img.shields.io/github/issues-raw/5ergiu/docker-traefik-portainer-nginx-symfony-react?style=for-the-badge" height="20"/></a>
<a href="https://github.com/tjackenpacken/taskbar-groups/"><img alt="Last commit" src="https://img.shields.io/github/last-commit/5ergiu/docker-traefik-portainer-nginx-symfony-react?style=for-the-badge" height="20"/></a>
<a href="https://github.com/tjackenpacken/taskbar-groups/blob/master/LICENSE"><img alt="Latest version" src="https://img.shields.io/github/license/5ergiu/docker-traefik-portainer-nginx-symfony-react?style=for-the-badge" height="20"/></a>
</p>

📖 Contents
========

* [Tech stack](#-tech-stack)
* [Installation](#-installation)
* [Configuration](#-configuration)
* [Folder structure](#-folder-structure)
* [Scripts](#-scripts)
* [Release notes](#-release-notes)
* [Development](#-development)
* [License](#-license)

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 🧰 Tech stack

| Stack           | Technology                                                                                                                                                                                                                                                           |
|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 🛠️ Environment | [Docker](https://www.docker.com/)                                                                                                                                                                                                                                    |
| 💻 Backend      | [Symfony](https://symfony.com/) using [PHP-FPM](https://www.php.net/manual/en/install.fpm.php) 8.1.1 (with [OPcache](https://devdojo.com/bobbyiliev/how-to-speed-up-your-laravel-application-with-php-opcache) & [JIT compiler](https://kinsta.com/blog/php-8/#jit)) |
| 🌐 Frontend     | [React](https://reactjs.org/) using [TypeScript](https://www.typescriptlang.org/)                                                                                                                                                                                    |
| 🛢 Database     | [MySQL](https://www.mysql.com/)                                                                                                                                                                                                                                      |
| 🗄️ Server      | [Traefik](https://traefik.io/) (Reverse Proxy) [Nginx](https://www.nginx.com/) (serving static files and bridging fastCGI protocols)                                                                                                                                 |

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 💾 Installation

To get started, make sure you have [Docker](https://docs.docker.com/desktop/#download-and-install) & [Docker compose](https://docs.docker.com/compose/install)
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

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 🔧 Configuration

The configuration is mostly controlled through environment variables.
There are the usual env variables used by Symfony and some used to configure Docker and PHP.
More info on each of the variables and their roles can be found in the default env file - **.env.default**.

Also, there are 2 docker-compose files, the **docker-compose.dev.yml** file is used for local development, whilst
the other one is used for prod environment.

⚠️These share the same services, so you need to specify the correct file when building images/containers, you don't have to specify a file for running docker-compose commands
on **backend** or **frontend** containers.

🚨 The frontend part is built with create-react-app, so for the dev environment, a frontend development server is started automatically(with the command **yarn start**),
so no need to run "watch" or anything, just make your changes and save the file, the page will automatically refresh for you to see the changes.

📦 Packages:
* The frontend only has the create-react-app(typescript) installation dependencies.
* The backend is has two additional packages besides the installation dependencies: [doctrine](https://github.com/doctrine/orm#readme) and a [health check bundle](https://github.com/MacPaw/symfony-health-check-bundle#symfony-health-check-bundle) for the backend API.

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 📁 Folder structure

- `.docker` Configuration files
- `backend` Symfony PHP framework + everything related to backend
- `frontend` React JS framework + everything related to frontend
- `scripts` to ease development or any script that can be used for the project
- `storage` used to store docker volumes data such as MySQL data or Portainer data

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 📜 Scripts

- **./scripts/install.sh** *(in project root)*: Installs the project (can be used for dev & PROD)
- **./scripts/bin [and the command you want to run]** *(in project root)*:
  ```
   ./scripts/bin make:controller TestController
   ./scripts/bin doctrine:migrations:migrate
  ```
- **./scripts/yarn [and the command you want to run]** *(in project root)*: Run console commands on frontend
  ```
   ./scripts/yarn build
   ./scripts/yarn test
  ```

#### 🍪 You could also create some aliases to further shorten these commands

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 📰 Release Notes

1. Pull code from main git repo
2. If necessary:
    1. Run migrations *(in project root)*: **./scripts/bin doctrine:migrations:migrate**
    2. Install new dependencies *(in project root)*: **./scripts/bin composer install**
    3. Build frontend assets *(in project root)*: **./scripts/yarn build**
    4. Restart/rebuild docker images/containers

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 💻 Development

* Each feature/task/issue is developed on a separate branch
* [SOLID](https://geekflare.com/php-solid-principles/)
* [Mobile first design](https://medium.com/@Vincentxia77/what-is-mobile-first-design-why-its-important-how-to-make-it-7d3cf2e29d00)
* [BEM methodology for CSS](https://en.bem.info/methodology/)
* Translations ordered alphabetically for ease of use

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 📄 License
This project is licensed under the [MIT License](https://github.com/5ergiu/docker-traefik-portainer-nginx-symfony-react/blob/main/LICENSE).
