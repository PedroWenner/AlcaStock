--SELECT * FROM PRODUTOS
--CREATE TABLE MARCAS
--(
--	ID INT IDENTITY PRIMARY KEY,
--	NOME VARCHAR(MAX)
--)


--INSERT INTO MARCAS (NOME) VALUES ('ACME CORP');
--INSERT INTO MARCAS (NOME) VALUES ('TECH INNOVATIONS');
--INSERT INTO MARCAS (NOME) VALUES ('FUTURE ELECTRONICS');
--INSERT INTO MARCAS (NOME) VALUES ('VISIONARY GADGETS');
--INSERT INTO MARCAS (NOME) VALUES ('GLOBAL GOODS');
--INSERT INTO MARCAS (NOME) VALUES ('QUANTUM SOLUTIONS');
--INSERT INTO MARCAS (NOME) VALUES ('NEXTGEN TECHNOLOGIES');
--INSERT INTO MARCAS (NOME) VALUES ('ELITE ELECTRONICS');
--INSERT INTO MARCAS (NOME) VALUES ('DYNAMIC DEVICES');
--INSERT INTO MARCAS (NOME) VALUES ('PRIME PRODUCTS');

SELECT
	CASE WHEN ATIVO = 'S' THEN 'ATIVO' ELSE 'INATIVO' END AS ATIVO,
	M.NOME AS NOME_MARCA,
	UM.NOME AS NOME_UNIDADE_MEDIDA,
	*
FROM PRODUTOS P
JOIN MARCAS M ON M.ID = P.MARCA
JOIN fcUnidadesMedidas() UM ON UM.ID = P.UNIDADE_MEDIDA
WHERE 1=1