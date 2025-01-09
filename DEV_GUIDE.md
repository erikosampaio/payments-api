# Guia do Desenvolvedor - Sistema de Pagamentos

Este guia fornece informações técnicas sobre a implementação do sistema de pagamentos, abrangendo tanto o backend quanto o frontend.

## Stack Tecnológico

### Backend (API Rails)
- **Ruby**: 3.0.0
- **Rails**: 7.x
- **Banco de Dados**: PostgreSQL
- **Autenticação**: JWT (JSON Web Tokens)
- **Testes**: RSpec
- **Documentação API**: Swagger/OpenAPI

### Frontend (React/TypeScript)
- **Framework**: React 18
- **Linguagem**: TypeScript
- **Bundler**: Vite
- **Estilização**: CSS Modules
- **Gerenciador de Estado**: React Context API
- **Requisições HTTP**: Fetch API

## Arquitetura

### Backend
- **Padrão API**: REST
- **Versionamento**: Via URL (v1)
- **Serialização**: JSON
- **CORS**: Habilitado para ambiente de desenvolvimento
- **Gateways de Pagamento**: 
  - PagSeguro
  - Mercado Pago

### Frontend
- **Arquitetura**: Component-Based
- **Roteamento**: React Router
- **Padrões**: 
  - Container/Presenter
  - Custom Hooks
  - Context API para estado global

## Estrutura do Projeto

### Backend
```
app/
├── controllers/
│   └── api/
│       └── v1/
│           ├── payments_controller.rb
│           └── sessions_controller.rb
├── models/
│   ├── payment.rb
│   └── user.rb
├── services/
│   └── payment_processors/
│       ├── pagseguro.rb
│       └── mercado_pago.rb
└── serializers/
    └── payment_serializer.rb
```

### Frontend
```
src/
├── components/
│   ├── common/
│   └── payments/
├── contexts/
├── hooks/
├── services/
└── types/
```

## APIs e Integrações

### Endpoints da API

#### Autenticação
- `POST /login`: Login do usuário
- `POST /logout`: Logout do usuário

#### Pagamentos
- `GET /api/v1/payments`: Lista pagamentos
- `POST /api/v1/payments`: Cria pagamento
- `GET /api/v1/payments/:id`: Detalhes do pagamento
- `DELETE /api/v1/payments/:id`: Cancela pagamento

### Simulação de Erros
Para testar cenários de erro nos gateways:
- PagSeguro: Data de expiração vazia
- Mercado Pago: CVC vazio
- Ambos: Data de expiração e CVC vazios

## Ambiente de Desenvolvimento

### Configuração do Backend
```bash
# Instalação de dependências
bundle install

# Setup do banco de dados
rails db:create
rails db:migrate

# Servidor de desenvolvimento
rails s -p 3001
```

### Configuração do Frontend
```bash
# Instalação de dependências
npm install

# Servidor de desenvolvimento
npm run dev
```

## Testes

### Backend (RSpec)
```bash
# Executa todos os testes
bundle exec rspec

# Executa testes específicos
bundle exec rspec spec/controllers/api/v1/payments_controller_spec.rb
```

## Deploy

### Backend
- Ambiente: Docker
- Banco de Dados: PostgreSQL em container separado
- Proxy Reverso: Nginx

### Frontend
- Build: `npm run build`
- Hosting: Nginx servindo arquivos estáticos

## Boas Práticas

### Backend
- Seguir princípios SOLID
- Usar serviços para lógica de negócios complexa
- Manter controllers enxutos
- Documentar endpoints com Swagger

### Frontend
- Componentização
- Separação de responsabilidades
- Tipagem forte com TypeScript
- Hooks customizados para lógica reutilizável
