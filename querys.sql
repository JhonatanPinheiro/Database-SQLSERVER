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

