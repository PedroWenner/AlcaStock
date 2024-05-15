using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public static class PageUtility
{
    /// <summary>
    /// Envolve o conte�do em uma declara��o javascript.
    /// </summary>
    /// <remarks>O m�todo retorna a declara��o no seguinte formato: 
    /// <code><script type="text/javascript">Conte�do do script</script> </code></remarks>
    /// <param name="content">Conte�do que ser� envolvido na declara��o javascript.</param>
    /// <returns>Declara��o javascript com o conte�do inserido internamente.</returns>
    public static string SurroundWithJavascriptDeclaration(string content)
    {
        return string.Format("<script type=\"text/javascript\">{0}</script>", content);
    }

    /// <summary>
    /// Retorna a declara��o javascript de inclus�o de arquivo externo.
    /// </summary>
    /// <param name="url">A url do script externo a ser inserido.</param>
    /// <returns>Declara��o de client script externo.</returns>
    public static string GetClientScriptInclude(string url)
    {
        if (!HttpUtil.IsNormalized(url))
            url = HttpUtil.NormalizeUrl(url);
        return string.Format("<script src=\"{0}\" type=\"text/javascript\" charset=\"iso-8859-1\"></script>", url);
    }

    /// <summary>
    /// Retorna a declara��o javascript de inclus�o de arquivo externo.
    /// </summary>
    /// <param name="page">A p�gina de onde ser� extraido o ApplicationPath.</param>
    /// <param name="url">A url do script externo a ser inserido.</param>
    /// <returns>Declara��o de client script externo.</returns>
    public static string GetClientScriptInclude(Page page, string url)
    {
        if (!HttpUtil.IsNormalized(url))
            url = HttpUtil.NormalizeUrl(page, url);
        return string.Format("<script src=\"{0}\" type=\"text/javascript\"></script>", url);
    }

    /// <summary>
    /// Retorna a declara��o CSS de inclus�o de arquivo externo.
    /// </summary>
    /// <param name="url">A url do CSS externo a ser inserido.</param>
    /// <returns>Declara��o de CSS externo.</returns>
    public static string GetCSSInclude(string url)
    {
        if (!HttpUtil.IsNormalized(url))
            url = HttpUtil.NormalizeUrl(url);
        return string.Format("<link href=\"{0}\" rel=\"stylesheet\" type=\"text/css\"/>", url);
    }

    /// <summary>
    /// Insere o esquema de onmouseover e onmouseout para mudar a cor da linha
    /// </summary>
    /// <param name="e">DataGridItemEventArgs</param>
    public static void InserirColorChangeLinhasGrid(DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            e.Item.Attributes.Add("onmouseover", "this.style.backgroundColor='#E0DFE3'");
            e.Item.Attributes.Add("onmouseout", "this.style.backgroundColor='white';");
        }
        if (e.Item.ItemType == ListItemType.AlternatingItem)
        {
            e.Item.Attributes.Add("onmouseover", "this.style.backgroundColor='#E0DFE3'");
            e.Item.Attributes.Add("onmouseout", "this.style.backgroundColor='#F5F5F5';");
        }
    }
}