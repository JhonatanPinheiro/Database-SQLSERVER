---------####################################################################################-----------
-- Banco de Dados SQL do Zero ao Avançado + Projetos Reais 2023 - Andre Iacono

-- Estamos utilizando o banco SAKILA nas demostrações das query - Caso queira baixar coloquei em meu repositório o banco de dados + schema
--------####################################################################################------------

-- 31. Operador REGEXP
SELECT * FROM actor act
WHERE act.first_name REGEXP '^a'; -- Irá pegar todos que SOMENTE  começa com a letra (a) indiferente se tiverem UPPER/LOWER 

SELECT * FROM actor act
WHERE act.first_name REGEXP '^a|^b'; -- Irá pegar todos que SOMENTE começa com a letra (a) e (b) indiferente se tiverem UPPER/LOWER 

SELECT * FROM actor act
WHERE act.first_name REGEXP '^c|a|b'; -- Irá pegar todos COMEÇA com a letra (c) OU CONTÉM TAMBÉM EM QUALQUER LUGAR as letras (a) e (b) indiferente se tiverem UPPER/LOWER 

SELECT * FROM actor act
WHERE act.first_name REGEXP '^a|^b'; -- Irá pegar todos que SOMENTE começa com a letra (a) e (b) indiferente se tiverem UPPER/LOWER 

SELECT * FROM actor act
WHERE act.first_name REGEXP '^[cam]a'; -- Irá pegar todos que SOMENTE começa com as letras (ca), (aa) e (ma) , indiferente se tiverem UPPER/LOWER 

SELECT * FROM actor act
WHERE act.first_name REGEXP '[aeiou]dy'; -- Irá pegar todos que SOMENTE TENHA AS letras (a), (e) , (i) , (o) OU (u) em algum lugar do registro E em seguida venha com (dy) em algum lugar também  indiferente se tiverem UPPER/LOWER 

-- https://www.freecodecamp.org/news/sql-contains-string-sql-regex-example-query/ 
--  LINK acima para melhor entendimento e mais informações do uso do LIKE e REGEXP


-- 59. Utilizando o ANY

-- Primeira maneira
SELECT pa.customer_id,pa.amount, COUNT(*)
FROM payment pa
GROUP BY pa.customer_id 
HAVING COUNT(*) > 35;

-- Segunda maneira
SELECT pa.customer_id,pa.amount, COUNT(*) AS Compras_realizadas
FROM payment pa
GROUP BY pa.customer_id 
HAVING  Compras_realizadas > 35;

-- Pegando todos os clientes que fizeram acima de 15 compras (tabela: payment) e monstrando todas as informações da tabela customer (nome, sobrenome, etc...) - Utilizando o IN #Dentro-Contido
SELECT * 
FROM customer c 
WHERE c.customer_id IN(
	
	SELECT pa.customer_id
	FROM payment pa
	GROUP BY pa.customer_id 
	HAVING COUNT(*) > 35

);

-- Pegando todos os clientes que fizeram acima de 15 compras (tabela: payment) e monstrando todas as informações da tabela customer (nome, sobrenome, etc...) - Utilizando o ANY #Qualquer Um
SELECT * 
FROM customer c 
WHERE c.customer_id = ANY(
	
	SELECT pa.customer_id
	FROM payment pa
	GROUP BY pa.customer_id 
	HAVING COUNT(*) > 35

);





