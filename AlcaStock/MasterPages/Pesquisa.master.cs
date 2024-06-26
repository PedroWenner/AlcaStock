using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPages_Pesquisa : System.Web.UI.MasterPage
{
    #region Propriedades

    /// <summary>
    /// Titulo da página de consulta.
    /// Ex: ((MasterPage)Master).Titulo = "Consulta de Pessoas";
    /// </summary>
    public string Titulo
    {
        get { return lblTituloPagina.Text; }
        set { lblTituloPagina.Text = value; }
    }

    #endregion Propriedades

    #region Métodos

    /// <summary>
    /// Cálcula o tamanho do titulo conforme o texto enviado
    /// </summary>
    public void CalculaTitulo()
    {
        int tamanho;
        tamanho = ((Titulo.Length) * 7);
        IdTitulo.Style.Add(HtmlTextWriterStyle.Width, tamanho.ToString());
    }

    #endregion Métodos

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.Controls.Add(new LiteralControl(PageUtility.GetCSSInclude("~/Library/Estilos/LayoutConsulta.css")));

        Utilitarios.AtribuirFuncoesJava(Parent.Page);
        CalculaTitulo();

        if (!(Page is AppBasePage))
            throw new InvalidOperationException("Atenção, para uso desta master page, a content page deve herdar de AppBasePage.");
    }
}