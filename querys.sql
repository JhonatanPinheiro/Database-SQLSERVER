----------------------- SEÇÃO 23: E O BUSINESS INTELLIGENCE? --------------------
---------------------------------------SEÇÃO 24: MÓDULO SQL SERVER - ELEVANDO O NÍVEL --------------------

-- Evitando Redudância você evita que seu HD cresça 
-- Consequência de ter um banco relacional são os JOINS que são necessarios fazer, que faz com que o processamento do banco suba lá em cima e o desempenho caía para baixo!




----------------------SEÇÃO 24: MÓDULO SQL SERVER - ELEVANDO O NÍVEL -----------------
---------------------------------93. Criando uma conta na Microsoft e baixando  o SQL Server 2014----------------------
---------------------------------94. Instalando o SQL Server 2014 e seus pré-requisitos--------------------------------
---------------------------------95. O Client do SQL Server e seus Bancos de Sistema-----------------------------------

-- Segue algumas novidade usando o SQLSERVER 
-- Fazendo multiplos comentarios em SQLSERVER  /**/

CREATE DATABASE AULA_SQL
CREATE DATABASE AULA_SQL02

-- Não é necessario usar ponto e virgula no final do comando/query

-- O SQLserver tem algo chamado processamento ASSÍNCRONO, ou seja sem ordem !
/*
GO é o delimitador do SQLServer. 

Para que eu utilizo o GO?
Resposta:  Para executar por parte , que será uma forma mais segura e certa , fazendo com que a prioridade seja escolhida vamos dizer ! 
	Quebrar os comandos do SQLServer em pacotes TCP IP para que chegue na ordem sicrona no servidor !
*/

/*
	Existe um recursos chamado no SQLServer de:              , dentro do banco que ele já te aponta se tem alguma coisa errada no seu comando !   
*/

CREATE DATABASE BANCO04
GO

USE BANCO04
GO

CREATE TABLE TESTE(
	NOME VARCHAR(30)
)
GO

--------------------------------------------------SEÇÃO 25: ARQUITETURA DO SQL SERVER ----------
----------------------------------97. Arquivos LDF e MDF--------------------------------


/*O que é uma arquitetura? 
Resposta: É como  se comporta os arquivos que compoe o Banco de dados 
*/
 

 /*
 
 MFD -> MASTER DATA FILE -> Armazena DADOS
 LDF -> LOG DATA FILE -> Armazena LOGS
 
 */


---------------------------------------SEÇÃO 24: MÓDULO SQL SERVER - ELEVANDO O NÍVEL --------------------

-- Evitando Redudância você evita que seu HD cresça 
-- Consequência de ter um banco relacional são os JOINS que são necessarios fazer, que faz com que o processamento do banco suba lá em cima e o desempenho caía para baixo!

-- Não é necessario usar ponto e virgula no final do comando/query

-- O SQLserver tem algo chamado processamento ASSÍNCRONO, ou seja sem ordem !
/*
GO é o delimitador do SQLServer. 

Para que eu utilizo o GO?
Resposta:  Para executar por parte , que será uma forma mais segura e certa , fazendo com que a prioridade seja escolhida vamos dizer ! 
	Quebrar os comandos do SQLServer em pacotes TCP IP para que chegue na ordem sicrona no servidor !
*/

/*
	Existe um recursos chamado no SQLServer de:              , dentro do banco que ele já te aponta se tem alguma coisa errada no seu comando !   
*/

CREATE DATABASE BANCO04
GO

USE BANCO04
GO

CREATE TABLE TESTE(
	NOME VARCHAR(30)
)
GO

--------------------------------------------------SEÇÃO 25: ARQUITETURA DO SQL SERVER ----------

CREATE TABLE TB_EMPRESA(
	ID INT,
    NOME VARCHAR(50)
)
GO

------------------------------------99. Constraints Nomeadas, Identity, SP_COLUMNS e SP_HELP------------------------------------------

-- CONECTANDO A UM BANCO

USE EMPRESA
GO

-- CRIANDO TABELAS

CREATE TABLE ALUNO(
	IDALUNO INT PRIMARY KEY IDENTITY,
    NOME VARCHAR(30) NOT NULL,
    SEXO CHAR(1) NOT NULL,
    NASCIMENTO DATE NOT NULL,
    EMAIL VARCHAR(30) UNIQUE
)
GO


/*CRIANDO UMA CONSTRAINTS FORA DA TABELA*/
ALTER TABLE ALUNO
ADD CONSTRAINT CK_SEXO CHECK (SEXO IN('M','F'))
GO

-- IDENTITY É O AUTO_INCREMENT DO MYSQLSERVER

-- CRIANDO UM RELACIONAMENTO 1 X 1 
CREATE TABLE ENDERECO(
    IDENDERECO INT PRIMARY KEY IDENTITY(100,10),
    BAIRRO VARCHAR(30),
    UF CHAR(2) NOT NULL
    CHECK(UF IN('RJ','SP','MG')),
    ID_ALUNO INT UNIQUE
)
GO


-- CRIANDO A FK
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_ALUNO
FOREIGN KEY(ID_ALUNO) REFERENCES ALUNO(IDALUNO)
GO


-- COMANDO DE DESCRICAO
/*PROCEDURES - JÁ CRIADAS E ARMAZENAS NO SISTEMA*/
SP_COLUMNS ALUNO  --Ele vai me trazer as descrições das colunas bem detralhadas
GO

SP_HELP ALUNO -- Ele vai me trazer as descrições das colunas muito mais detralhadas
GO


-- INSERINDO DADOS
INSERT INTO ALUNO VALUES('ANDRE','M','1981/12/09','ANDRE@IG.COM')
INSERT INTO ALUNO VALUES('ANA','F','1978/12/09','ANA@IG.COM')
INSERT INTO ALUNO VALUES('RUI','M','1951/12/09','RUI@IG.COM')
INSERT INTO ALUNO VALUES('JOÃO','M','2002/11/09','JOAO@IG.COM')
GO


-----------------------------------------100. A função IFNULL( ), Clausula ambígua e a função GETDATE()-----------------------------

INSERT INTO ENDERECO VALUES('FLAMENGO','RJ',1)
INSERT INTO ENDERECO VALUES('MORUMBI','SP',2)
INSERT INTO ENDERECO VALUES('CENTRO','MG',4)
INSERT INTO ENDERECO VALUES('CENTRO','SP',6)
GO

-- CRIANDO A TABELA CLIENTE 1 X N

CREATE TABLE TELEFONE(
    IDTELEFONE INT PRIMARY KEY IDENTITY,
    TIPO CHAR(3) NOT NULL,
    NUMERO VARCHAR(10) NOT NULL,
    ID_ALUNO INT,
    CHECK (TIPO IN('RES','COM','CEL'))

)
GO

INSERT INTO TELEFONE VALUES('CEL','7899889',1)
INSERT INTO TELEFONE VALUES('RES','4325444',1)
INSERT INTO TELEFONE VALUES('COM','4354354',2)
INSERT INTO TELEFONE VALUES('CEL','2344556',2)
GO
 

SELECT * FROM ALUNOS
GO


-- PEGAR DATA ATUAL
SELECT GETDATE()
GO


/*CLASULA AMBIGUA*/
SELECT A.NOME,T.TIPO, T.NUMERO, E.BAIRRO,E.UF 
FROM ALUNO A
INNER JOIN TELEFONE T 
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E 
ON A.IDALUNO = E.ID_ALUNO
GO 

/*USANDO LEFT JOIN*/
SELECT A.NOME,T.TIPO,T.NUMERO,E.BAIRRO,E.UF 
FROM ALUNO A
LEFT JOIN TELEFONE T 
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E 
ON A.IDALUNO = E.ID_ALUNO
GO 



/*IF NULL EM SQLSERVER -> Se o campo for vazio*/
SELECT A.NOME,
       ISNULL(T.TIPO, 'SEM') AS "TIPO",
       ISNULL(T.NUMERO,'NUMERO') AS "TELEFONE",
       E.BAIRRO,
       E.UF 
FROM ALUNO A LEFT JOIN TELEFONE T 
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECI E 
ON A.IDALUNO = E.ID_ALUNO
GO


---------------------------------------------101. Trabalhando com Datas--------------------------------------

-- DATAS 

SELECT * FROM ALUNO
GO

SELECT NOME,NASCIMENTO
FROM ALUNO
GO

-- DATEDIFF - CALCULA A DIFERENÇA ENTRE 2 DATAS 
SELECT NOME, GETDATE() FROM ALUNO
GO

-- GETDATE() -> TRÁS O DIA E HORA
 
 SELECT NOME, DATEDIFF(DAY,NASCIMENTO,GETDATE()) AS "IDADE"
 FROM ALUNO
 GO

--OU

 SELECT NOME, DATEDIFF(DAY,NASCIMENTO,GETDATE()) AS IDADE
 FROM ALUNO
 GO

SELECT NOME, DATEDIFF(DAY,NASCIMENTO,GETDATE()) IDADE
FROM ALUNO
GO

/*3 PASSO - RETORNO EM INTEIRO + OPER MATEMATICA*/
SELECT NOME, (DATEDIFF(DAY,NASCIMENTO,GETDATE())/365) AS "IDADE"
FROM ALUNO
GO
 
-- Usando a função MONTH, Nesse Query estamos descubrindo o quantos meses tem cada aluno
SELECT NOME, (DATEDIFF(MONTH,DAY,NASCIMENTO,GETDATE())/12) AS "IDADE"
FROM ALUNO
GO
-----------------------------------------OU
-- Usando a função YEAR, Nesse Query estamos descubrindo o quantos meses tem cada aluno
SELECT NOME, DATEDIFF(YEAR,NASCIMENTO,GETDATE()) AS "IDADE"
FROM ALUNO
GO

/*DATANAME - TRAZ O NOME DA PARTE DA DATA EM QUESTAO             -> Funções de DATA, lembrando que ele traz em STRING*/

--Irá me trazer o dia da semana
SELECT NOME,DATENAME(WEEKDAY,NASCIMENTO)
FROM ALUNO
GO
-- Irá me trazer o mês
SELECT NOME,DATENAME(MONTH,NASCIMENTO)
FROM ALUNO
GO
-- Irá me trazer o ano
SELECT NOME,DATENAME(YEAR,NASCIMENTO)                   
FROM ALUNO
GO


/*DATEPART - Mesma coisa DATANAME porém seu retorno é inteiro INT, podendo fazer conta*/
SELECT NOME, DATEPART(MONTH,NASCIMENTO), DATENAME(MONTH,NASCIMENTO) 
FROM ALUNO
GO

/*DATEADD -  RETORNA UMA DATA SOMANDO A OUTRA DATA*/
SELECT DATEADD(DAY,365,GETDATE())

SELECT DATEADD(YEAR,10,GETDATE())

-- COMO FUNCIONA ENTEDENDO
/*
SELECT DATEADD(INTERVALO,INCREMENT_INT,EXPESSION)
SELECT DATEADD(DIA_ANO_MÊS,QUANTO,GETDATE())
SELECT DATEADD(OQUE,QUANTO,GETDATE())

*/

---------------------------------------102. Conversões de tipos de dados--------------------------
SELECT 1 + '1'
GO ---------Retornou: 2

SELECT '1' + '1'
GO ---------Retornou: 11

SELECT 'Curso de banco de dados' + '1'
GO ----------Retonou: Curso de banco de dados1


SELECT 'CURSO DE BANCO DE DADOS' + 1
GO --------Retornou: Deu um erro ao converter o varchar valor 'CURSO DE BANCO DE DADOS' para o tipo de dados int


--------FUNÇÕES DE CONVERSAO DE DADOS
-- Esse Cast é uma função para converte dados ou seja converter tipos 
SELECT CAST('1' AS INT) + CAST('1' AS INT)
GO

-- STRING + STRING = CONCATENAÇÃO
-- NUMERO + NUMERO = SOMA DOS NUMEROS

-------------------MANUAL PARA CONVERSORES----------------
-- https://docs.microsoft.com/pt-br/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver16


/*CONVERSAO E CONCATENAÇÃO*/
SELECT NOME,
NASCIMENTO
FROM ALUNO
GO

SELECT NOME,
DAY(NASCIMENTO)
FROM ALUNO

-- Ocorrerá um erro , pois na hora da conversão ele está barrando na hora da barra, pois MONTH,DAY e YEAR está como inteiro mas as barras estão como String
SELECT NOME,
MONTH(NASCIMENTO) + '/' + MONTH(NASCIMENTO) + '/' + YEAR(NASCIMENTO)
FROM ALUNO


-- Resolvendo esse erro, solução abaixo : 
SELECT NOME,
CAST(DAY(NASCIMENTO) AS VARCHAR) + '/' +
CAST(MONTH(NASCIMENTO) AS VARCHAR) + '/' +
CAST(YEAR(NASCIMENTO)  AS VARCHAR) + '/'
FROM ALUNO
GO
 

-------------------------103. Correção do Exercício proposto--------------------------------
SELECT NOME,
CAST(DAY(NASCIMENTO) AS VARCHAR) + '/' +
CAST(MONTH(NASCIMENTO) AS VARCHAR) + '/' +
CAST(YEAR(NASCIMENTO)  AS VARCHAR) AS "NASCIMENTO"
FROM ALUNO
GO
 

------------------------------------------------104. A função CHARINDEX
-- O que essa função CHARINDEX?
-- Reposta: Retorma um inteiro
-- CONTAGEM DEFAULT - INICIA EM 01


SELECT NOME, CHARINDEX(OQUE,ONDE,A_PARTIR_DE)

SELECT NOME,CHARINDEX('A',NOME) AS INDICE FROM ALUNO
GO

-- Explicando como funciona essa função: Elá é alimentado por dois parâmetros. 1- Primeiro seria Oque eu quero, 2- Nome_Atributo

SELECT NOME,CHARINDEX('A',NOME,2) AS INDICE 
FROM ALUNO
GO



-------------------------------105. Utilizando Bulk Insert - Desafio utilizando CHARINDEX-----------------------------
-- BULK INSERT IMPORTAÇÃO DE ARQUIVOS
CREATE TABLE LANCAMENTO_CONTABIL(
    CONT INT,
    VALOR INT,
    DEB_CRED CHAR(1)
)
GO

-- Explicando como funciona
BULK INSERT LANCAMENTO_CONTABIL  --Informa o nome da tabela que deseja alimentar
FROM 'C:\ARQUIVOS\CONTAS.TXT' -- Informa o caminho
WITH(
-- São 3 paramêtros a serem preenchidos
    FIRSTROW = 2,     -- Informa de apartir de qual linha do arquivo irá começar a considerar para alimentar
    DATAFILETYPE = 'char', -- Precisa informa qual tipo seria esse arquivo que irei importe (INT,CHAR,DOUBLE)
    FIELDTERMINATOR = ';', -- Precisa colocar como os campos termina. Nesse caso seria ';' , pois todas as linha estão com o ponto de virgula informando seja o final . Ou seja o delimitador dele .
    ROWTERMINATOR = '\n' -- esse parâmetro é fixo, ele significar o ASC do teclado . Tipos de configurações do teclado

)


--Comando pronto para executar ! 
BULK INSERT LANCAMENTO_CONTABIL
FROM 'C:\ARQUIVOS\CONTAS.TXT'
WITH(

    FIRSTROW = 2,
    DATAFILETYPE = 'char',
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '\n'

)


SELECT * FROM LANCAMENTO_CONTABIL

DELETE FROM LANCAMENTO_CONTABIL

/*DESAFIO DO SALDO*/
-- 1 Preciso de uma Query que traga o número da conta saldo - Devedor e Credor
SELECT CONTA AS 'NUMERO DE CONTA',VALOR AS 'SALDO',DEB_CRED AS 'DEVEDOR (D) OU CREDOR (C)'
WHERE DEB_CRED = ((CHARINDEX('D',DEB_CRED)) OR (CHARINDEX('C',DEB_CRED)))
FROM LANCAMENTO_CONTABIL
GO



-------------------------------------106. Correção do desafio - Exibindo o Saldo-------------------

/*  NUMEROS - COMO EU ALTERO UM NÚMERO PARA NEGATIVO SEM MODIFICA-LO?   5 = 5 -> 5x(-1) = -5 */

SELECT CONTA,VALOR,DEB_CRED,
CHARINDEX('D', DEB_CRED) AS DEBITO,
CHARINDEX('C',DEB_CRED) AS CREDITO,
CHARINDEX('C',DEB_CRED) * 2 - 1 AS MULTIPLICADOR
FROM LANCAMENTO_CONTABIL
GO

SELECT CONTA,
SUM(VALOR * (CHARINDEX('C',DEB_CRED) * 2 - 1)) AS SALDO
FROM LANCAMENTO_CONTABIL
GROUP BY CONTA
GO




