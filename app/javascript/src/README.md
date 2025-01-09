# Frontend Payment App

Interface de usuário moderna e responsiva para o sistema de pagamentos, construída com React e TypeScript.

## Tecnologias Utilizadas

- React
- TypeScript
- Vite
- CSS Modules

## Estrutura do Projeto

```
src/
├── components/     # Componentes React reutilizáveis
├── App.tsx        # Componente principal
├── main.tsx       # Ponto de entrada
└── index.css      # Estilos globais
```

## Desenvolvimento Local

1. Instale as dependências:
```bash
npm install
# ou
yarn install
```

2. Execute o servidor de desenvolvimento:
```bash
npm run dev
# ou
yarn dev
```

O frontend estará disponível em `http://localhost:5173`

## Principais Funcionalidades

- Dashboard de pagamentos
- Formulário de criação de pagamentos
- Visualização detalhada de transações
- Interface responsiva e intuitiva

## Integração com a API

O frontend se comunica com a API Rails através de endpoints RESTful, utilizando fetch para requisições HTTP.
