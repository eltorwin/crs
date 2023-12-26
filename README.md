
Я разворачивал под rvm: Ruby(3.2.2), Rails(7.1.2)

# Установка
1. В файле config/database.yml изменить user и password от бд на свой

2. В консоли выполнить
```
bundle install

rails db:create
rails db:migrate
rails db:seed
```

3. Запуск
```
foreman start
```