# Desafio: Implementação de Listagem de Orders

## Objetivo
Criar o usecase de listagem das orders utilizando três abordagens diferentes:
- Endpoint REST (GET /order)
- Serviço ListOrders com gRPC
- Query ListOrders utilizando GraphQL

Além disso, você deve configurar o ambiente de desenvolvimento com Docker e criar as migrações necessárias para o banco de dados.

---

## Passos para Executar o Desafio

### 1. Configurar o Ambiente

#### a. Requisitos
Certifique-se de que você possui os seguintes softwares instalados:
- [Go](https://go.dev/doc/install)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Golang-migrate](https://github.com/golang-migrate/migrate/)
- [Makefile](https://www.gnu.org/software/make/manual/make.html)

#### b. Iniciar os Serviços
1. Clone o repositório do projeto:
   ```bash
   git clone https://github.com/leonardo-gmuller/clean-arch-challenge
   cd clean-arch-challenge
   ```

2. Suba os contêineres Docker:
   ```bash
   docker compose up -d
   ```
Esse comando irá:

- Configurar o banco de dados e suas tabelas.

- Deixar a aplicação pronta para receber requisições.

---

### 2. Endpoints Implementados

#### a. REST
- **Endpoint**: `GET /order`
- **Descrição**: Retorna a lista de orders cadastradas no banco de dados.
- **Porta**: `8080`

#### b. gRPC
- **Serviço**: `ListOrders`
- **Descrição**: Método gRPC para listagem de orders.
- **Porta**: `50051`

#### c. GraphQL
- **Query**: `ListOrders`
- **Descrição**: Query para listagem de orders.
- **Porta**: `8080`

---

### 3. Estrutura do Banco de Dados

#### a. Migrações
As migrações estão localizadas no diretório `iternal/infra/database/migrations/`.



---

### 4. Testando a Aplicação

#### a. API HTTP
Os arquivos localizados no diretório `api` foi incluído no projeto para facilitar os testes. Ele contém requisições para:
- Criar uma order.
- Listar as orders.

Para executar, abra o arquivo em um editor como o VS Code e use a extensão REST Client.

#### b. Postman/Insomnia
Você também pode importar as requisições para o Postman ou Insomnia. Certifique-se de usar as URLs e portas corretas:
- **REST**: `http://localhost:8080/order`
- **GraphQL**: `http://localhost:8081/graphql`

#### c. Testando o gRPC
Use uma ferramenta como [Evans](https://github.com/ktr0731/evans) para testar o serviço gRPC:
```bash
evans --host localhost --port 50051 repl
```
Dentro do REPL, use o comando `call ListOrders` para executar a query.

---

### 5. Estrutura de Pastas
- `api/`: Arquivos com requisições para testar a API REST.
- `infra/`: Arquivos de infraestrutura:
    - `grpc/` :Arquivos proto para definição do serviço gRPC.
    - `graphql/`: Esquema e resolvers para a API GraphQL.
    - `database/`: Arquivos de migração do banco de dados e repositórios.
- `cmd/`: Ponto de entrada para a aplicação.
- `internal/`: Implementação dos usecases, entities e events.

---

## Conclusão
Com esses passos, você estará pronto para implementar e testar a listagem das orders utilizando as três abordagens solicitadas.

