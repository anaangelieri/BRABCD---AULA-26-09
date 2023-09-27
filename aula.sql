/* Aula agrupamento*/
/*enunciado início da aula*/
drop database if exists aula_agrup;
CREATE DATABASE IF NOT EXISTS aula_agrup;
USE aula_agrup;
/* CRIAR TABELA */
CREATE TABLE IF NOT EXISTS FORNECEDOR (
IDFORNECEDOR INT,
NOME VARCHAR(45),
ENDERECO VARCHAR(45),
TELEFONE INT,
CIDADE VARCHAR(20),
EMAIL VARCHAR(25),
PRIMARY KEY (IDFORNECEDOR)
);
CREATE TABLE IF NOT EXISTS PRODUTO (
IDPRODUTO INT,
DESCRICAO VARCHAR(45),
PRECO DECIMAL(7,2),
UNIDADE VARCHAR(10),
IDFORNECEDOR INT,
PRIMARY KEY (IDPRODUTO),
FOREIGN KEY (IDFORNECEDOR) REFERENCES FORNECEDOR(IDFORNECEDOR)
ON DELETE CASCADE ON UPDATE CASCADE
/* na execução do delete ou update a ação será cascata
  se tiver registro na tabela filha será eliminado ou atualizado  */
);
INSERT INTO FORNECEDOR VALUES
(1,'PAPEL RECICLADO','RUA BRASIL,1000', 4441212, 'BRAGANÇA PAULISTA',
 'RECI@GMAIL.COM'),
(2,'CASA BAHIA','RUA DO MERCADO,200', 40338787, 'BRAGANÇA PAULISTA',
 'CASABAHIA@GMAIL.COM'),
(3,'LOJA CEM','RUA DO COMERCIO,9000', 40334455, 'BRAGANÇA PAULISTA',
 'LOJACEM@GMAIL.COM'),
(4,'MAGAZINE LUIZA','RUA PIRES PIMENTEL,500', 40331212, 'BRAGANÇA PAULISTA',
 'LUIZA@GMAIL.COM');
INSERT INTO PRODUTO VALUES
(100,'FOGAO', 800.50, 'PC',2),
(110,'GELADEIRA', 2000.70, 'PC',2),
(150,'FOGAO COOKTOP', 1300.40, 'PC',3),
(160,'AR CONDICIONADO', 1800, 'PC',4),
(170,'IMPRESSORA', 2800, 'PC',2),
(161,'NOTEBOOK', 3400, 'PC',2),
(180,'ASPIRADOR DE PO', 256, 'PC',1),
(181,'TV', 3800, 'PC',1),
(190,'TV', 3900, 'PC',2);

CREATE TABLE IF NOT EXISTS FAMILIA (
IDFAMILIA INT AUTO_INCREMENT,
DESCRICAO VARCHAR(45),
PRIMARY KEY (IDFAMILIA)
);

INSERT INTO FAMILIA VALUES
(idfamilia,'Linha Branca'),
(idfamilia, 'Informática');

select * from produto;
/*alterar a tab produto para ligar à tabela família*/
alter table PRODUTO 
add column IDFAMILIA INT,
add QTDE INT,
ADD foreign key(IDFAMILIA) references FAMILIA(IDFAMILIA)
ON DELETE CASCADE ON UPDATE CASCADE;

select * from produto;
/*atualizar a tab produto conforme dados do item 6*/

UPDATE PRODUTO 
SET IDFAMILIA=1,
	QTDE=8
WHERE IDPRODUTO=100;

UPDATE PRODUTO 
SET IDFAMILIA=1,
	QTDE=17
WHERE IDPRODUTO=110;

UPDATE PRODUTO 
SET IDFAMILIA=1,
	QTDE=10
WHERE IDPRODUTO=150;
select * from produto;
UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO>=160;

UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO=161;

UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO=170;
UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO=180;

UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO=181;

UPDATE PRODUTO 
SET IDFAMILIA=2,
	QTDE=12
WHERE IDPRODUTO=190;

/* para conferir se está ok*/

SELECT * FROM FORNECEDOR;
SELECT * FROM PRODUTO;
select * from familia;

#Aula
Select distinct (IDFORNECEDOR) from PRODUTO; #EXECUTA SÓ UMA OCORRÊNCIA
Select all (IDFORNECEDOR) from PRODUTO; #EXECUTA TODAS AS OCORRÊNCIAS

update FORNECEDOR
set CIDADE="SÃO PAULO"
where IDFORNECEDOR = 3;

select DESCRICAO, IDPRODUTO from PRODUTO
where IDFORNECEDOR = any
(select IDFORNECEDOR from FORNECEDOR where CIDADE like 'B%');

#update só altera o dado
#alter table altera uma coluna

#CONTAR
select count(*) from PRODUTO; #conta quantos registros tem na tabela produto
select * from PRODUTO;
#existem as funções count, sum, max, min, avg(media)

select count(*) from PRODUTO where DESCRICAO like 'T%';

select sum(PRECO) from PRODUTO;
select sum(PRECO) as 'Soma dos preços' from PRODUTO;
select count(IDFORNECEDOR) from PRODUTO where DESCRICAO like 'T%';
#SOMAR AS QUANT DOS PROD DO FORNECEDOR = 2
select sum(QTDE) from PRODUTO where IDFORNECEDOR = 2;
#MAIOR 
select max(PRECO) from PRODUTO;
#menor
select min(QTDE) from PRODUTO;
#média
select format(avg(PRECO),2) from PRODUTO;

select DESCRICAO, PRECO from PRODUTO order by PRECO desc limit 1; #de forma descendente limitando 1 único registro
#EXIBIR A MEDIA E CONTAR OS PRODUTOS
select avg (PRECO) as MEDIA, count(*) as 'Total de Itens' from PRODUTO;

#agrupamento
select CIDADE from FORNECEDOR group by CIDADE;
#contar quantos produtos tem em cada familia
select IDFAMILIA, count(*) from PRODUTO group by IDFAMILIA;

#SOMAR TODOS OS PREÇOS DOS PRODUTOS POR FORNECEDOR;
select IDFORNECEDOR, sum(PRECO) from PRODUTO group by IDFORNECEDOR; #OU SUBSTITUIR O ÚLTIMO IDFORNECEDOR POR 1 OU 2

#qual é a média das quantidades por familia;
select IDFAMILIA, avg(QTDE) from PRODUTO group by IDFAMILIA;

#exibir as medias dos preços por familia quando for maior que 1500
select IDFAMILIA, avg(PRECO) from PRODUTO group by IDFAMILIA having avg(PRECO) > 1500;

#EXIBIR QUANTOS PRODUTOS CADA FORNECEDOR TEM QUANDO FOR MAIOR QUE 2
select IDFORNECEDOR, count(QTDE) from PRODUTO group by IDFORNECEDOR having count(QTDE) > 2;
