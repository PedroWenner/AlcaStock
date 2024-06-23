ALTER FUNCTION [dbo].[getMENU]()  
RETURNS @MENU TABLE  
(                   
 [MENU_ID] INT,                   
 [ID] INT,                   
 [PARENT_ID] INT,                   
 [TEXTO] VARCHAR(100),                   
 [URL] VARCHAR(100),                   
 [BREAK_NEXT] BIT,                   
 [JSCRIPT_INI] VARCHAR(200),                   
 [JSCRIPT_FIM] VARCHAR(200),                   
 [INICIAR] BIT,                   
 [ORDEM] INT                   
)                   
AS                   
BEGIN                   
     
   --> INICIO  
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR])  
   VALUES (1, 100, NULL, N'&nbsp;Início', N'~/Inicial.aspx', 0, NULL, NULL, NULL)  
  
   --> CADASTROS  
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR])  
   VALUES (2, 200, NULL, N'Cadastros', N'', 0, NULL, NULL, NULL)  
  
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR], [ORDEM])  
   VALUES (3, 201, 200, N'Pessoas', N'~/Paginas/Pessoa/ConPessoa.aspx', 0, NULL, NULL, NULL, 1)  
  
   --INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR], [ORDEM])  
   --VALUES (4, 202, 200, N'Fornecedores', N'', 0, NULL, NULL, NULL, 2)  
  
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR], [ORDEM])  
   VALUES (5, 203, 200, N'Produtos', N'~/Paginas/Produto/ConProduto.aspx', 0, NULL, NULL, NULL, 3) 
   
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR])  
   VALUES (6, 300, NULL, N'Gerenciamento', N'', 0, NULL, NULL, NULL) 
   
   INSERT INTO @MENU ([MENU_ID], [ID], [PARENT_ID], [TEXTO], [URL], [BREAK_NEXT], [JSCRIPT_INI], [JSCRIPT_FIM], [INICIAR], [ORDEM])  
   VALUES (7, 301, 300, N'Vendas', N'~/Paginas/Gerenciamento/CadVenda.aspx', 0, NULL, NULL, NULL, 1)
                  
   RETURN;                   
                  
 --SELECT MAX(MENU_ID),MAX(ID) FROM MENU      
END  
    
--INSERT INTO MENU_GRUPO (USR_GRUPO_ID, MENU_ID) VALUES (1, 7)
--SELECT * FROM MENU_GRUPO