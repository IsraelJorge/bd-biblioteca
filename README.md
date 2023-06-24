# Projeto Node com Prisma - Guia de Início Rápido

Este é um guia de início rápido para configurar um projeto Node.js com o Prisma como ORM (Object-Relational Mapping). O Prisma é uma ferramenta poderosa que simplifica a interação com bancos de dados relacionais em projetos Node.js. Siga as etapas abaixo para começar a desenvolver seu projeto:

### Pré-requisitos

Antes de iniciar, verifique se você possui as seguintes ferramentas instaladas em seu sistema:

- [Node.js](https://nodejs.org) (versão 12 ou superior)

### Inicialize o projeto executando o seguinte comando:

```
npm install
or
yarn
```

Atualize a URL de conexão com o banco de dados de acordo com suas configurações locais ou de produção. Você pode fornecer a URL diretamente ou armazená-la em uma variável de ambiente no **.env**.

### Execute o seguinte comando para criar as tabelas no banco de dados com base no seu esquema definido:

`npx prisma migrate dev --name init`
