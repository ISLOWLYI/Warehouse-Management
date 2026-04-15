## Запуск

```bash
docker compose up --build
```
В браузере:

http://localhost:3000


## Команды

Консоль Rails:

```bash
docker compose exec web bin/rails console
```

Миграции:

```bash
docker compose exec web bin/rails db:migrate
```