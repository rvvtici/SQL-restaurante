-- printa: nome do prato, ingrediente e fornecedor do pedido 3
-- relaciona os ingredientes usados no pedido aos fornecedores
SELECT
  p.nome_prato,
  i.nome_ingrediente,
  f.nome AS fornecedor_nome
FROM
  pedido ped
INNER JOIN pedido_pratos pp ON ped.pedido_ID = pp.pedido_ID
INNER JOIN pratos p ON pp.nome_prato = p.nome_prato
INNER JOIN ingredientes i ON p.nome_prato = i.nome_prato
INNER JOIN produto prod ON i.produto_ID = prod.produto_ID
INNER JOIN fornecedor f ON prod.fornecedor_ID = f.fornecedor_ID
WHERE
  ped.pedido_ID = 3;






-- printa: id_ingrediente, nome ingrediente, qtde recebida pelos fornecedores e qtde usada nos pratos, estoque atual
-- usa-se para ter controle do estoque atual
SELECT 
  prod.produto_id as ID,
  prod.nome AS ingrediente,
  COALESCE(SUM(prod.quantidade), 0) AS qtde_recebida, 
  COALESCE(SUM(i.quantidade), 0) AS qtde_usada,
  (COALESCE(SUM(prod.quantidade), 0) - COALESCE(SUM(i.quantidade), 0)) AS estoque_atual
FROM produto prod
INNER JOIN ingredientes i ON prod.produto_ID = i.produto_ID
INNER JOIN pedido_pratos pp ON i.nome_prato = pp.nome_prato
INNER JOIN pedido p ON pp.pedido_ID = p.pedido_ID
GROUP BY prod.nome, prod.produto_id;






--printa: nome do prato e a quantidade comprada
--consulta para ver qual o prato menos comprado
SELECT 
  p.nome_prato, 
  COUNT(pp.pedido_ID) AS quantidade_comprada
FROM pratos p
LEFT JOIN pedido_pratos pp ON p.nome_prato = pp.nome_prato
GROUP BY p.nome_prato
ORDER BY quantidade_comprada ASC
LIMIT 1;




--printa: nome completo, numero total de atendimentos em um dia especifico (2024-11-21)
--para ver quem atendeu mais em um dia especifico
SELECT 
  CONCAT (f.nome, ' ', f.sobrenome) as nome_completo,
  SUM (m.numero_atendimento) as qtde_atendimentos
FROM 
  funcionario f
INNER JOIN garcom g ON g.CPF = f.CPF
INNER JOIN mesa m ON g.CPF = m.CPF
INNER JOIN pedido p ON m.pedido_ID = p.pedido_ID
WHERE p.data = '2024-11-21'
GROUP BY CONCAT (f.nome, ' ', f.sobrenome)
ORDER BY SUM (m.numero_atendimento) DESC;










--printa: nome completo e respectivas funções em ordem crescente dos nomes
--para ver a função de cada pessoa
SELECT 
    CONCAT(f.nome, ' ', f.sobrenome) AS nome_completo,
    COALESCE(
        (SELECT 'Gerente' FROM gerente g WHERE g.CPF = f.CPF),
        (SELECT 'Cozinheiro' FROM cozinheiro c WHERE c.CPF = f.CPF),
        (SELECT 'Garçom' FROM garcom ga WHERE ga.CPF = f.CPF)
    ) AS função
FROM 
    funcionario f
ORDER BY nome_completo asc;










--printa nome produto e quantidade entregue em um dia específico
SELECT 
    p.nome, 
    SUM(p.quantidade) AS total_entregue
FROM produto p
WHERE p.data_entrega = '2024-11-05'
GROUP BY p.nome










--printar todos os pratos de um cardápio específico
SELECT pr.nome_prato
FROM pratos pr
INNER JOIN cardapio c ON c.nome_cardapio = pr.nome_cardapio
WHERE c.nome_cardapio = 'Principal';










--printa nome ingrediente e quantidade
--todos os ingredientes e qtde para fazer um prato específico
SELECT 
    i.nome_ingrediente, 
    i.quantidade
FROM ingredientes i
INNER JOIN pratos p ON p.nome_prato = i.nome_prato
WHERE p.nome_prato = 'Filé Mignon';










--printa todas as mesas com seus respectivos: numero de atendimento, qtde clientes, garçom responsável
SELECT 
    m.numero_atendimento, 
    m.quantidade_cliente, 
    CONCAT(f.nome, ' ', f.sobrenome) AS nome_garcom
FROM mesa m
INNER JOIN garcom g ON g.CPF = m.CPF
INNER JOIN funcionario f ON f.CPF = g.CPF;










--printa nome completo, linguas faladas e fluencias de garcom especifico
SELECT 
    CONCAT(f.nome, ' ', f.sobrenome) AS nome_completo, 
    lg.lingua, 
    lg.fluencia
FROM lingua_garcom lg
INNER JOIN garcom ga ON lg.CPF = ga.CPF
INNER JOIN funcionario f ON f.CPF = ga.CPF
WHERE f.CPF = '33333333333'










--printa cpf, nome, sobrenome, total_pedidos
--quantos pedidos cada cozinheiro fez
SELECT 
    c.CPF, 
    f.nome,
    f.sobrenome,
    COUNT(p.pedido_ID) AS total_pedidos
FROM pedido p
INNER JOIN cozinheiro c ON p.CPF = c.CPF
INNER JOIN funcionario f ON c.CPF = f.CPF
GROUP BY c.CPF;