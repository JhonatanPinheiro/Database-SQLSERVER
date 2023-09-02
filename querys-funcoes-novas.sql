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


