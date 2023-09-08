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


-- 62. Funções com Strings (TRIM, LTRIM , RTRIM,LENGTH, LOCATE, REPEAT,RIGHT, LEFT )
SELECT TRIM('          Carros         '); -- Remove os espaços da esquerda e direita

SELECT LTRIM('          Carros'); -- Remove os espaços somente da esquerda

SELECT RTRIM('Carros         '); -- Remove os espaços somente da direita

-- Cuidado ao Usar essa função para remover algum caracter, pois ao utilizar deve-se entender muito bem como ele  funciona, pois como será mostrado abaixo pode reparar que dependendo da forma que utilizamos ele, ele removerá o caracter tanto no início como no final OU até mesmo só no inicio como só no final
# TRIM com BOTH

SELECT  TRIM(BOTH 'a' FROM  'aaaaaaaaaaCarros'); -- Irá remover todas os 'a' (Lower) que estão començando e mostará apenas 'Carros'

SELECT  TRIM(BOTH 'a' FROM  'aaaaaaaaaaCarrosaaaaaaaaaa'); -- Irá remover todas os 'a' (Lower) que estão començando e no final da palavras, monstrando apenas a palavra 'Carros'

SELECT  TRIM(BOTH 'aaaaaaaaa' FROM  'aaaaaaaaaaCarros'); -- Irá remover apenas os 9  'a' (Lower) que estão començando e mostará apenas 'a' 'aCarros'

SELECT  TRIM(BOTH 'aaaaaaaaaaaaC' FROM  'aaaaaaaaaaaaCarros') -- Irá remover todos os 'a' (Lower) que estão començando e mostará apenas 'arros';


# TRIM com LEADING
SELECT  TRIM(LEADING 'a' FROM  'aaaaaaaaaaCarrosaaaaaaaaaaaaaaaaaaa'); -- Irá remover todas os 'a' (Lower) que estão començando/inicio e mostará apenas 'Carrosaaaaaaaaaaaaaaaaaaa'

SELECT  TRIM(TRAILING 'a' FROM  'aaaaaaaaaaCarrosaaaaaaaaaaaaaaaaaaa'); -- Irá remover todas os 'a' (Lower) que estão terminando/fim e mostará apenas 'aaaaaaaaaaCarros'


#Usando a função LOCATE 
SELECT LOCATE('o','Jhonatan P'); -- Informa qual posição encontra-se a letra 'o'. Deve lembrar que quando temos mais de uma letra repetida ele mostrará a posição apenas de primeira letra equivalente. Deve-se manter atento também pois essa função ela não fazer a distinguinção de UPPER e LOWER, ela mostrará apenas a posição da letra mesmo sendo Maiúsculo ou MIN

#Usando LENGTH
SELECT LENGTH('Jhonatan'); -- Mostrará o tamanho da String (Quantidades de caracteres que possui a palavra "Jhonatan") -> Começa a contagem do 1

#Usando REPEAT
SELECT REPEAT('Jhonatan',10); -- Mostrará o nome 10 vezes "JhonatanJhonatanJhonatanJhonatanJhonatanJhonatanJhonatanJhonatanJhonatanJhonatan"

#Usando RIGHT
SELECT RIGHT('Carros',4); -- Mostrará apenas as 4 últimos caracteres "rros"

SELECT LEFT('Carros',4); -- Mostrará apenas as 4 primeiros caracteres "Carr"