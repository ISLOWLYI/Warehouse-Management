# Warehouse Management

## Запуск

```bash
docker compose up --build
```

Приложение: http://localhost:3000

## Миграции и демо-данные

```bash
docker compose exec web bundle exec rails db:migrate
docker compose exec web bundle exec rails db:seed
```

## Данные для входа

| Email | Пароль |
|-------|--------|
| admin@warehouse.ru | password123 |

http://localhost:3000/users/sign_in

Регистрация новых пользователей — только по приглашению администратора через раздел "Участники" склада.

## Команды

Консоль:

```bash
docker compose exec web bin/rails console
```

Миграции:

```bash
docker compose exec web bin/rails db:migrate
```

Сброс БД:

```bash
docker compose exec web bin/rails db:drop db:create db:migrate db:seed
```
