using Alcastock.Controllers;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Paginas_Pessoa_PesqPessoas : AppBasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ((MasterPages_Pesquisa)Master).Titulo = "Pesquisa de Pessoas";

        txtPesquisa.Focus();
        this.Form.DefaultButton = btnConsultar.UniqueID;

        if (!IsPostBack)
        {

        }
    }

    protected void btnConsultar_Click(object sender, EventArgs e)
    {
        string tipoConsulta = ddlPSQ.SelectedValue;
        string descricao = txtPesquisa.Text.Trim();
        Consultar(tipoConsulta, descricao);
    }

    protected void grdResultados_ItemCreated(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Header)
        {
            e.Item.CssClass = "gridview-header";
        }
    }

    protected void grdResultados_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            e.Item.CssClass = "data-row";
        }
    }

    private void Consultar(string tipoConsulta, string descricao)
    {
        PessoaController pessoaController = new PessoaController();
        List<PessoaModel> pessoas = pessoaController.ConsultarPessoas(tipoConsulta, descricao);

        if (pessoas == null || pessoas.Count == 0)
        {
            pessoas = new List<PessoaModel>
            {
                new PessoaModel { NOME = "Nenhum registro encontrado" }
            };
        }

        grdResultados.DataSource = pessoas;
        grdResultados.DataBind();
    }
}