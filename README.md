Projeto de Banco de Dados (CCD110)
Modelagem, Projeto Lógico de Base de Dados e Implementação

Este projeto modela o funcionamento de um restaurante, abordando o gerenciamento de fornecedores, funcionários, cardápios e pedidos. Nesse sentido, inclui a modelagem Entidade-Relacionamento Estendido (MER), a transformação para o Modelo Relacional (MR), a normalização das tabelas e a implementação de DDL para consulta dos dados em SQL com auxílio do SGBD PostgreSQL.

MODELO ENTIDADE-RELACIONAMENTO ESTENDIDO (MER)

![firefox_WEJIvg0Ihm](https://github.com/user-attachments/assets/2cc97008-f06e-429f-9f18-ebf767796c74)


MODELO RELACIONAL(MR)


![firefox_j9JztRPvB9](https://github.com/user-attachments/assets/d35ca82c-4dec-40a5-9844-e8a81aa2fa6c)



O modelo relacional foi desenvolvido a partir do MER, garantindo a normalização e a integridade dos dados. Cada tabela foi criada para representar uma entidade ou relacionamento do modelo conceitual, considerando as chaves primárias e estrangeiras para formar as relações.

Regras de transformação aplicadas sobre o MER para derivação no MR:
Entidades multivaloradas: Línguas, pedidos
Entidade composta: Nome do funcionário
Especialização: Gerente, garçom, cozinheiro (subclasses de “Funcionários”)

RELAÇÕES NO MR
Chaves Primárias: definidas para identificar unicamente os registros em cada tabela:
Exemplo: A tabela “produto” utiliza Produto_ID como chave primária para garantir que cada produto seja único
Chaves Estrangeiras: implementadas para estabelecer relações entre tabelas:
Exemplo: A tabela “produto possui ID_Fornecedor como chave estrangeira, conectando cada produto ao fornecedor correspondente.

NORMALIZAÇÃO
O processo de normalização foi aplicado para garantir a consistência e a eficiência do banco de dados. As tabelas foram normalizadas até a Terceira Forma Normal (3FN), eliminando redundâncias e garantindo que cada atributo seja dependente de sua chave primária. O processo seguiu as etapas descritas abaixo:
Primeira Forma Normal (1N)
Todos os atributos foram garantidos como atômicos.
Atributos multivalorados, como Línguas do Garçom, foram separados em uma tabela auxiliar (Línguas_Garçom) para armazenar os idiomas e o nível de fluência associados a cada garçom, garantindo que cada coluna contenha apenas um valor.
Segunda Forma Normal (2FN)
Todas as tabelas já estão na 1FN.
Não existem dependências parciais, ou seja, todos os atributos não-chave dependem totalmente da chave primária.
Exemplo: Na tabela Produto, os atributos Nome, Qtd, Nota_Fiscal e Data_Entrega dependem exclusivamente do Produto_ID, que é a chave primária.
Terceira Forma Normal (3FN)
As dependências transitivas foram eliminadas, assegurando que todos os atributos não-chave dependam apenas da chave primária.
Exemplo: Em Funcionario, atributos como Nome, Idade e Endereço dependem diretamente do CPF, e nenhuma outra dependência transitiva é mantida.
Utilização de Tabelas Auxiliares
Para garantir a integridade e organizar dados relacionados, foram criadas tabelas auxiliares, como:
Línguas_Garçom: Gerencia o atributo multivalorado "Línguas", conectando garçom e os idiomas que falam com níveis de fluência específicos.
Pedido_Pratos: Tabela intermediária que resolve o relacionamento N:N entre Pedido e Pratos, armazenando combinações de pedidos e pratos.

Integrantes:
Gabriel Andrade Rosa Oliveira 	RA: 22.124.075-7
Ravi Macedo Ticianelli Lima 		RA: 22.124.069-0

