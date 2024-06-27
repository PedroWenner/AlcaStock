INSERT INTO Produtos (CODIGO, TIPO, NOME, MARCA, UNIDADE_MEDIDA, CUSTO, PERC_LUCRO, PRECO_VENDA, CONTROLA_ESTOQUE, ESTOQUE_MININO, SIS_USER_INSERT, SIS_DATA_INSERT, ATIVO)
VALUES 
('PROD001', 1, 'PRODUTO A', 1, 1, 10.00, 20.00, 12.00, 'S', 5, 'TESTE', GETDATE(), 'S'),
('PROD002', 1, 'PRODUTO B', 1, 1, 15.00, 25.00, 18.75, 'S', 3, 'TESTE', GETDATE(), 'S'),
('PROD003', 1, 'PRODUTO C', 1, 1, 20.00, 30.00, 26.00, 'S', 10, 'TESTE', GETDATE(), 'S'),
('PROD004', 1, 'PRODUTO D', 1, 1, 5.00, 15.00, 5.75, 'S', 2, 'TESTE', GETDATE(), 'S'),
('PROD005', 1, 'PRODUTO E', 1, 1, 8.00, 18.00, 9.44, 'S', 6, 'TESTE', GETDATE(), 'S'),
('PROD006', 1, 'PRODUTO F', 1, 1, 7.00, 17.00, 8.19, 'S', 4, 'TESTE', GETDATE(), 'S'),
('PROD007', 1, 'PRODUTO G', 1, 1, 12.00, 22.00, 14.64, 'S', 8, 'TESTE', GETDATE(), 'S'),
('PROD008', 1, 'PRODUTO H', 1, 1, 25.00, 35.00, 33.75, 'S', 7, 'TESTE', GETDATE(), 'S'),
('PROD009', 1, 'PRODUTO I', 1, 1, 30.00, 40.00, 42.00, 'S', 9, 'TESTE', GETDATE(), 'S'),
('PROD010', 1, 'PRODUTO J', 1, 1, 22.00, 32.00, 29.04, 'S', 1, 'TESTE', GETDATE(), 'S'),
('PROD011', 1, 'PRODUTO K', 1, 1, 18.00, 28.00, 23.76, 'S', 4, 'TESTE', GETDATE(), 'S'),
('PROD012', 1, 'PRODUTO L', 1, 1, 16.00, 26.00, 20.64, 'S', 5, 'TESTE', GETDATE(), 'S'),
('PROD013', 1, 'PRODUTO M', 1, 1, 9.00, 19.00, 10.71, 'S', 3, 'TESTE', GETDATE(), 'S'),
('PROD014', 1, 'PRODUTO N', 1, 1, 11.00, 21.00, 13.31, 'S', 2, 'TESTE', GETDATE(), 'S'),
('PROD015', 1, 'PRODUTO O', 1, 1, 6.00, 16.00, 6.96, 'S', 1, 'TESTE', GETDATE(), 'S'),
('PROD016', 1, 'PRODUTO P', 1, 1, 4.00, 14.00, 4.56, 'S', 7, 'TESTE', GETDATE(), 'S'),
('PROD017', 1, 'PRODUTO Q', 1, 1, 3.00, 13.00, 3.39, 'S', 6, 'TESTE', GETDATE(), 'S'),
('PROD018', 1, 'PRODUTO R', 1, 1, 2.00, 12.00, 2.24, 'S', 8, 'TESTE', GETDATE(), 'S'),
('PROD019', 1, 'PRODUTO S', 1, 1, 1.00, 11.00, 1.11, 'S', 9, 'TESTE', GETDATE(), 'S'),
('PROD020', 1, 'PRODUTO T', 1, 1, 50.00, 60.00, 80.00, 'S', 10, 'TESTE', GETDATE(), 'S');

WITH CTE_Produtos AS (
    SELECT 
        CODIGO, 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS SeqNum
    FROM 
        Produtos
)
UPDATE Produtos
SET CODIGO = CTE_Produtos.SeqNum
--SELECT Produtos.CODIGO, CTE_Produtos.CODIGO, SeqNum
FROM Produtos
JOIN CTE_Produtos ON Produtos.CODIGO = CTE_Produtos.CODIGO;

INSERT INTO Pessoas (NOME, CPF, DATA_NASC, SEXO, NOME_MAE, CPF_MAE, NOME_PAI, CPF_PAI, TELEFONE_RESIDENCIAL, TELEFONE_CELULAR, EMAIL, SIS_USUARIO_INSERT)
VALUES 
('Fernanda Oliveira', '445.678.901-26', '1997-12-04', 'F', 'Larissa Oliveira', '445.690.123-45', 'Henrique Oliveira', '445.678.901-23', '555-4567', '555-8901', 'fernanda.oliveira@example.com', 'admin'),
('Júlio Almeida', '556.789.012-31', '1989-02-21', 'M', 'Mônica Almeida', '556.701.234-56', 'Jorge Almeida', '556.789.012-34', '555-5678', '555-9012', 'julio.almeida@example.com', 'admin');

INSERT INTO Pessoas (NOME, CPF, DATA_NASC, SEXO, NOME_MAE, CPF_MAE, NOME_PAI, CPF_PAI, TELEFONE_RESIDENCIAL, TELEFONE_CELULAR, EMAIL, SIS_USUARIO_INSERT)
VALUES 
('Juliana Ferreira', '890.123.456-78', '1983-02-25', 'F', 'Camila Ferreira', '890.134.567-89', 'João Ferreira', '890.123.456-77', '555-8901', '555-2345', 'juliana.ferreira@example.com', 'admin'),
('Pedro Costa', '901.234.567-89', '1979-09-14', 'M', 'Mariana Costa', '901.245.678-90', 'Rafael Costa', '901.234.567-88', '555-9012', '555-3456', 'pedro.costa@example.com', 'admin'),
('Laura Mendes', '012.345.678-90', '1998-06-22', 'F', 'Fernanda Mendes', '012.356.789-01', 'Gabriel Mendes', '012.345.678-99', '555-0123', '555-4567', 'laura.mendes@example.com', 'admin'),
('Tiago Rocha', '112.345.678-91', '1981-04-17', 'M', 'Sofia Rocha', '112.367.890-12', 'Leonardo Rocha', '112.345.678-90', '555-1234', '555-5678', 'tiago.rocha@example.com', 'admin'),
('Beatriz Santos', '223.456.789-02', '1993-12-09', 'F', 'Aline Santos', '223.478.901-23', 'André Santos', '223.456.789-01', '555-2345', '555-6789', 'beatriz.santos@example.com', 'admin'),
('Lucas Martins', '334.567.890-13', '1986-07-19', 'M', 'Helena Martins', '334.589.012-34', 'Eduardo Martins', '334.567.890-12', '555-3456', '555-7890', 'lucas.martins@example.com', 'admin'),
('Sofia Costa', '445.678.901-24', '1997-11-30', 'F', 'Isabel Costa', '445.690.123-45', 'Felipe Costa', '445.678.901-23', '555-4567', '555-8901', 'sofia.costa@example.com', 'admin'),
('Fernando Almeida', '556.789.012-35', '1984-08-02', 'M', 'Verônica Almeida', '556.701.234-56', 'Hugo Almeida', '556.789.012-34', '555-5678', '555-9012', 'fernando.almeida@example.com', 'admin'),
('Aline Souza', '667.890.123-46', '1996-03-15', 'F', 'Renata Souza', '667.812.345-67', 'Renato Souza', '667.890.123-45', '555-6789', '555-0123', 'aline.souza@example.com', 'admin'),
('Gabriel Oliveira', '778.901.234-57', '1987-10-23', 'M', 'Amanda Oliveira', '778.923.456-78', 'Gustavo Oliveira', '778.901.234-56', '555-7890', '555-1234', 'gabriel.oliveira@example.com', 'admin'),
('Mariana Ferreira', '889.012.345-68', '1991-05-12', 'F', 'Letícia Ferreira', '889.034.567-89', 'Fábio Ferreira', '889.012.345-67', '555-8901', '555-2345', 'mariana.ferreira@example.com', 'admin'),
('Renato Silva', '990.123.456-79', '1978-09-27', 'M', 'Júlia Silva', '990.145.678-90', 'Adriano Silva', '990.123.456-78', '555-9012', '555-3456', 'renato.silva@example.com', 'admin'),
('Camila Costa', '101.234.567-80', '1999-01-03', 'F', 'Bianca Costa', '101.256.789-01', 'Rogério Costa', '101.234.567-89', '555-0123', '555-4567', 'camila.costa@example.com', 'admin'),
('André Pereira', '112.345.678-92', '1982-06-20', 'M', 'Denise Pereira', '112.367.890-12', 'Ricardo Pereira', '112.345.678-90', '555-1234', '555-5678', 'andre.pereira@example.com', 'admin'),
('Patrícia Lima', '223.456.789-03', '1994-08-11', 'F', 'Tatiana Lima', '223.478.901-23', 'Maurício Lima', '223.456.789-01', '555-2345', '555-6789', 'patricia.lima@example.com', 'admin'),
('Eduardo Souza', '334.567.890-14', '1980-03-28', 'M', 'Elaine Souza', '334.589.012-34', 'Cláudio Souza', '334.567.890-12', '555-3456', '555-7890', 'eduardo.souza@example.com', 'admin');

INSERT INTO Pessoas (NOME, CPF, DATA_NASC, SEXO, NOME_MAE, CPF_MAE, NOME_PAI, CPF_PAI, TELEFONE_RESIDENCIAL, TELEFONE_CELULAR, EMAIL, SIS_USUARIO_INSERT)
VALUES 
('João Silva', '123.456.789-01', '1985-05-20', 'M', 'Maria Silva', '109.876.543-21', 'José Silva', '123.450.987-65', '555-1234', '555-5678', 'joao.silva@example.com', 'admin'),
('Ana Costa', '234.567.890-12', '1990-08-15', 'F', 'Clara Costa', '234.561.234-56', 'Carlos Costa', '234.567.890-10', '555-2345', '555-6789', 'ana.costa@example.com', 'admin'),
('Carlos Pereira', '345.678.901-23', '1975-01-30', 'M', 'Helena Pereira', '345.671.234-56', 'Paulo Pereira', '345.678.901-11', '555-3456', '555-7890', 'carlos.pereira@example.com', 'admin'),
('Maria Oliveira', '456.789.012-34', '2000-12-25', 'F', 'Ana Oliveira', '456.781.234-56', 'Pedro Oliveira', '456.789.012-10', '555-4567', '555-8901', 'maria.oliveira@example.com', 'admin'),
('José Santos', '567.890.123-45', '1995-07-10', 'M', 'Joana Santos', '567.891.234-56', 'Roberto Santos', '567.890.123-44', '555-5678', '555-9012', 'jose.santos@example.com', 'admin'),
('Paula Lima', '678.901.234-56', '1988-03-05', 'F', 'Juliana Lima', '678.912.345-67', 'Fernando Lima', '678.901.234-55', '555-6789', '555-0123', 'paula.lima@example.com', 'admin'),
('Ricardo Alves', '789.012.345-67', '1992-11-11', 'M', 'Patrícia Alves', '789.123.456-78', 'Marcos Alves', '789.012.345-66', '555-7890', '555-1234', 'ricardo.alves@example.com', 'admin');