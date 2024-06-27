using Alcastock.Controllers;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Paginas_Pessoa_PesqPessoas : AppBasePage
{
    #region Eventos
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
        List<PessoaModel> pessoas = Consultar(tipoConsulta, descricao);

        CarregarGrid(pessoas);
    }

    protected void grdResultados_ItemCreated(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Header)
        {
            e.Item.CssClass = "gridview-header";
        }

        if (e.Item.ItemType == ListItemType.Pager)
        {
            e.Item.CssClass = "gridview-footer";

            foreach (Control control in e.Item.Controls)
            {
                if (control is TableCell)
                {
                    TableCell cell = (TableCell)control;

                    foreach (Control pagerControl in cell.Controls)
                    {
                        if (pagerControl is LinkButton)
                        {
                            LinkButton link = (LinkButton)pagerControl;
                            link.CssClass = "link-body-emphasis link-offset-2 link-underline-opacity-25 link-underline-opacity-75-hover";
                        }
                        else if (pagerControl is Label)
                        {
                            Label label = (Label)pagerControl;
                            label.CssClass = "link-body-emphasis link-offset-2 link-underline-opacity-25 link-underline-opacity-75-hover";
                        }
                    }
                }
            }
        }
    }

    protected void grdResultados_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton lkbNome = (LinkButton)e.Item.FindControl("lkbNome");
            lkbNome.Text = e.Item.Cells[0].Text + " - " + e.Item.Cells[1].Text;
            e.Item.CssClass = "data-row";
        }
    }

    protected void grdResultados_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        grdResultados.CurrentPageIndex = e.NewPageIndex;
        btnConsultar_Click(null, null);
    }

    protected void grdResultados_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Selecionar":
                OK(e.Item.ItemIndex);
                break;
        }
    }

    protected void ddlPSQ_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPSQ.SelectedValue == "1")
        {
            txtPesquisa.Attributes.Add("oninput", "formatarCPF(this)");
            txtPesquisa.MaxLength = 11;
        }
        else
        {
            txtPesquisa.Attributes.Remove("oninput");
            txtPesquisa.MaxLength = int.MaxValue;
        }
    }

    #endregion Eventos

    #region Metodos

    private void CarregarGrid(List<PessoaModel> pessoas)
    {
        // Ordena a lista de pessoas por nome
        pessoas.Sort((p1, p2) => p1.NOME.CompareTo(p2.NOME));

        grdResultados.DataSource = pessoas;
        grdResultados.DataBind();
    }

    private List<PessoaModel> Consultar(string tipoConsulta, string descricao)
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

        return pessoas;
    }

    /// <summary>
    /// Método para criar o javascript responsável por retornar os dados para o TextBox e o Hidden do componente
    /// </summary>
    /// <param name="index">Indice da linha selecionada</param>
    public void OK(int index)
    {
        string tipoConsulta = ddlPSQ.SelectedValue;
        string descricao = txtPesquisa.Text.Trim();
        List<PessoaModel> pessoas = Consultar(tipoConsulta, descricao);

        if (pessoas.Count > 0)
        {
            // Obter os dados da pessoa selecionada
            string pessoaId = grdResultados.Items[index].Cells[0].Text.Replace("&nbsp;", "");
            string nome = grdResultados.Items[index].Cells[1].Text.Replace("'", "");
            string cpf = grdResultados.Items[index].Cells[3].Text.Replace("&nbsp;", "");
            string dataNasc = grdResultados.Items[index].Cells[4].Text.Replace("&nbsp;", "");
            string email = grdResultados.Items[index].Cells[5].Text.Replace("&nbsp;", "");

            // Gerar o script JavaScript para ser executado na janela principal
            string retorno = @"
            <script type='text/javascript'>
            function Retorno() {
                var retorno = {
                    value: '" + pessoaId + @"', 
                    cpf: '" + cpf + @"',
                    data_nasc: '" + dataNasc + @"',
                    text: '" + nome + @"',
                    email: '" + email + @"'
                };
                if (window.opener && window.opener.searchWindowCallback) { window.opener.searchWindowCallback(retorno); }
                window.close();
            }
            Retorno();
            </script>";

            // Registrar o script para ser executado no lado do cliente
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Retorno_" + this.ClientID, retorno, false);
        }
    }

    #endregion Metodos
}