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
        int saldoRestante = 0;
        if (!string.IsNullOrWhiteSpace(productId))
            saldoRestante = produtoController.ConultaSaldoProdutoRestante(int.Parse(productId));

        return saldoRestante.ToString();
    }
}