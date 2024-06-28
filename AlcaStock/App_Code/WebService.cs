using Alcastock.Controllers;
using Produto.Models;
using System.Collections.Generic;
using System.Web.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    public WebService()
    {
        // Construtor
    }

    [WebMethod]
    public string GetProductBalance(string productId)
    {
        ProdutoController produtoController = new ProdutoController();
        List<ProdutoModel> produtos = produtoController.ConsultarProdutoPorId(productId);
        ProdutoModel produto = produtos[0];

        return produto.ESTOQUE_MININO.ToString();
    }
}