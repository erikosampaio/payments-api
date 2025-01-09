# Payment API

Uma API Rails moderna para processamento de pagamentos, oferecendo endpoints RESTful seguros e eficientes.

## Tecnologias Principais

- Ruby 3.2.2
- Rails 7.x
- PostgreSQL
- RSpec para testes

## Configuração

1. Clone o repositório
```bash
git clone [repository-url]
cd payments-api
```

2. Instale as dependências
```bash
bundle install
```

3. Configure o banco de dados
```bash
rails db:create
rails db:migrate
```

## Executando a Aplicação

```bash
rails server
```

A API estará disponível em `http://localhost:3001`

## Testes

Execute a suite de testes com:
```bash
rspec
```

## Endpoints Principais

- `POST /api/v1/payments` - Criar novo pagamento
- `GET /api/v1/payments` - Listar pagamentos
- `GET /api/v1/payments/:id` - Detalhes do pagamento
- `DELETE /api/v1/payments/:id` - Cancelar pagamento

- `POST /login` - Autenticar usuário
- `POST /logout` - Deslogar usuário

## Docker

Para executar com Docker:
```bash
docker-compose up --build
```
