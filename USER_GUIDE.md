# Guia do Usuário - Sistema de Pagamentos

Bem-vindo ao nosso Sistema de Pagamentos! Este guia irá ajudá-lo a entender como testar as funcionalidades desse sistema.

## 1. Login
- Acesse a página inicial
- Clique em "Admin Area", disponível tanto na navbar como na tela de boas vindas
- Insira suas credenciais (e-mail e senha)
- Se ainda não possui conta, solicite acesso ao administrador do sistema
- Uma vez logado, é possível você fazer login

## 2. Dashboard Principal
Após fazer login, você terá acesso ao dashboard principal que exibe:
- Resumo dos seus últimos pagamentos
- Saldo atual
- Opções de menu principais

## 3. Visualizar Pagamentos
- Na tela principal, você encontra a lista completa dos pagamentos, bem como o total deles
- Clique em um pagamento específico para ver mais detalhes

## 4. Criar Novo Pagamento
1. Clique no menu de pagamento disponível tanto na navbar como na tela de boas vindas
2. Preencha as informações necessárias:
   - Nome do cartão
   - Número do cartão
   - Data de vencimento
   - Número de segurança
3. Revise os dados
4. Confirme o pagamento

## 5. Forçar erro no pagamento
Para forçar erro no pagamento, simulando uma negativa dos gateways (Pag Seguro e Mercado Pago):
1. Campo Expiry Date em branco força erro no Pag Seguro
2. Campo CVC em branco força erro no Mercado Pago
3. Ambos os campos acima em branco força erro nos dois gateways
