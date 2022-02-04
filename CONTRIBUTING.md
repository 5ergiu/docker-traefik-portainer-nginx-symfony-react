## 💻 Development

* Each feature/task/issue is developed on a separate branch
* [SOLID](https://geekflare.com/php-solid-principles/)
* [Mobile first design](https://medium.com/@Vincentxia77/what-is-mobile-first-design-why-its-important-how-to-make-it-7d3cf2e29d00)
* [BEM methodology for CSS](https://en.bem.info/methodology/)
* Translations ordered alphabetically for ease of use

[![-----------------------------------------------------](https://user-images.githubusercontent.com/56088716/103312593-8a37ff80-49eb-11eb-91d3-75488e21a0a9.png)]()

## 📰 Release Notes

1. Pull code from main git repo
2. If necessary:
    1. Run migrations *(in project root)*: **./scripts/bin doctrine:migrations:migrate**
    2. Install new dependencies *(in project root)*: **./scripts/bin composer install**
    3. Build frontend assets *(in project root)*: **./scripts/yarn build**
    4. Restart/rebuild docker images/containers

