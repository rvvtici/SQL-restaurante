CREATE TABLE restaurante (
  CNPJ VARCHAR(14) PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(300) NOT NULL
);


CREATE TABLE fornecedor (
  fornecedor_ID VARCHAR(10) PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  FOREIGN KEY (CNPJ) REFERENCES restaurante(CNPJ)
);


CREATE TABLE funcionario (
  CPF VARCHAR(11) PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  idade INT,
  endereco VARCHAR(300),
  CNPJ VARCHAR(14),
  FOREIGN KEY (CNPJ) REFERENCES restaurante(CNPJ)
);


CREATE TABLE produto (
  produto_ID INT PRIMARY KEY NOT NULL,
  nota_fiscal INT NOT NULL, 
  nome VARCHAR(100) NOT NULL,
  quantidade INT NOT NULL,
  data_entrega TIMESTAMP NOT NULL,
  fornecedor_ID VARCHAR(10) NOT NULL,
  FOREIGN KEY (fornecedor_ID) REFERENCES fornecedor(fornecedor_ID)
);


CREATE TABLE cardapio (
  nome_cardapio VARCHAR(100) PRIMARY KEY NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  FOREIGN KEY (CNPJ) REFERENCES restaurante(CNPJ)
);


CREATE TABLE pratos (
  nome_prato VARCHAR(100) PRIMARY KEY NOT NULL,
  tipo VARCHAR(100),
  nome_cardapio VARCHAR(100),  
  FOREIGN KEY (nome_cardapio) REFERENCES cardapio(nome_cardapio)
);


CREATE TABLE ingredientes (
  nome_ingrediente VARCHAR(100) PRIMARY KEY NOT NULL,
  nome_prato VARCHAR(100) NOT NULL,
  produto_ID INT NOT NULL,
  quantidade INT,
  FOREIGN KEY (nome_prato) REFERENCES pratos(nome_prato),
  FOREIGN KEY (produto_ID) REFERENCES produto(produto_ID)
);


CREATE TABLE gerente (
  CPF VARCHAR(11) PRIMARY KEY NOT NULL,
  FOREIGN KEY (CPF) REFERENCES funcionario(CPF)
);


CREATE TABLE cozinheiro (
  CPF VARCHAR(11) PRIMARY KEY NOT NULL,
  grau_tecnico VARCHAR(100),
  FOREIGN KEY (CPF) REFERENCES funcionario(CPF)
);


CREATE TABLE garcom (
  CPF VARCHAR(11) PRIMARY KEY NOT NULL,
  FOREIGN KEY (CPF) REFERENCES funcionario(CPF)
);


CREATE TABLE lingua_garcom (
  CPF VARCHAR(11) NOT NULL,
  lingua VARCHAR(100) NOT NULL,
  fluencia VARCHAR(100),
  FOREIGN KEY (CPF) REFERENCES garcom(CPF)
);


CREATE TABLE pedido (
  pedido_ID INT PRIMARY KEY NOT NULL,
  data TIMESTAMP,
  CPF VARCHAR(11), -- cpf do cozinheiro
  FOREIGN KEY (CPF) REFERENCES cozinheiro(CPF)
);


CREATE TABLE pedido_pratos (
  pedido_ID INT NOT NULL,
  nome_prato VARCHAR(100),
  FOREIGN KEY (pedido_ID) REFERENCES pedido(pedido_ID),
  FOREIGN KEY (nome_prato) REFERENCES pratos(nome_prato)
);


CREATE TABLE mesa (
  numero_atendimento INT PRIMARY KEY NOT NULL,
  quantidade_cliente INT,
  pedido_ID INT NOT NULL,
  CPF VARCHAR(11), --cpf do garcom
  FOREIGN KEY (pedido_ID) REFERENCES pedido(pedido_ID),
  FOREIGN KEY (CPF) REFERENCES garcom(CPF)
);


INSERT INTO restaurante (CNPJ, nome, endereco) VALUES
('12345678000123', 'Pobre Juan', 'Avenida Paulista, 1000, São Paulo');


INSERT INTO fornecedor (fornecedor_ID, nome, CNPJ) VALUES
('001', 'FG7 LTDA', '12345678000123'),
('002', 'Intermezzo LTDA', '12345678000123'),
('003', 'Spal LTDA', '12345678000123');


INSERT INTO cardapio (nome_cardapio, CNPJ) VALUES
('Principal', '12345678000123'),
('Bebidas', '12345678000123'),
('Sobremesas', '12345678000123');


INSERT INTO funcionario (CPF, nome, sobrenome, idade, endereco, CNPJ) VALUES
(11111111111, 'Carlos', 'Silva', 30, 'Rua A, 123, São Paulo', '12345678000123'),
(22222222222, 'Ana', 'Oliveira', 25, 'Rua B, 456, São Paulo', '12345678000123'),
(33333333333, 'Marcos', 'Santos', 28, 'Rua C, 789, São Paulo', '12345678000123'),
(44444444444, 'Fernanda', 'Costa', 40, 'Rua D, 101, São Paulo', '12345678000123'),
(55555555555, 'João', 'Pereira', 35, 'Rua E, 202, São Paulo', '12345678000123');


INSERT INTO gerente (CPF) VALUES
(44444444444);


INSERT INTO cozinheiro (CPF, grau_tecnico) VALUES
(11111111111, 'Técnico em Gastronomia'),
(22222222222, 'Técnico em Cozinha Internacional');


INSERT INTO garcom (CPF) VALUES
(33333333333),
(44444444444);


INSERT INTO lingua_garcom (CPF, lingua, fluencia) VALUES
(44444444444, 'Inglês', 'Avançado'),
(33333333333, 'Inglês', 'Fluente'),
(33333333333, 'Espanhol', 'Intermediário');


INSERT INTO pratos (nome_prato, tipo, nome_cardapio) VALUES
('Filé Mignon', 'Carne', 'Principal'),
('Risoto de Camarão', 'Frutos do Mar', 'Principal'),
('Petit gateau', 'Sobremesa', 'Sobremesas'),
('Coca-cola', 'Bebida', 'Bebidas');


INSERT INTO produto (produto_ID, nota_fiscal, nome, quantidade, data_entrega, fornecedor_ID) VALUES
(1, 001, 'Filé Mignon', 10, '2024-11-01', '002'),
(3, 001, 'Camarão', 15, '2024-11-03', '002'),
(2, 002, 'Arroz', 20, '2024-11-02', '003'),
(4, 003, 'Chocolate Meio Amargo', 10, '2024-11-04', '003'),
(5, 003, 'Farinha de Trigo', 25, '2024-11-05', '003'),
(6, 004, 'Coca-Cola', 50, '2024-11-06', '001');


INSERT INTO ingredientes (nome_ingrediente, nome_prato, produto_ID, quantidade) VALUES
('Filé Mignon', 'Filé Mignon', 1, 2),
('Arroz', 'Risoto de Camarão', 2, 1),
('Camarão', 'Risoto de Camarão', 3, 10),
('Chocolate Meio Amargo', 'Petit gateau', 4, 1),
('Farinha de Trigo', 'Petit gateau', 5, 1),
('Coca-Cola', 'Coca-cola', 6, 1);


INSERT INTO pedido (pedido_ID, data, CPF) VALUES
(1, '2024-11-20', '11111111111'),
(2, '2024-11-21', '22222222222'),
(3, '2024-11-21', '11111111111');


INSERT INTO pedido_pratos (pedido_ID, nome_prato) VALUES
(1, 'Filé Mignon'),
(2, 'Filé Mignon'),
(3, 'Risoto de Camarão'),
(3, 'Petit gateau');


INSERT INTO mesa (numero_atendimento, quantidade_cliente, pedido_ID, CPF) VALUES
(01, 1, 1, 44444444444),
(02, 1, 2, 44444444444),
(03, 1, 3, 33333333333);