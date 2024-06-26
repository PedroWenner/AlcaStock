﻿using Alcastock.Controllers;
using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Paginas_Pessoa_ConPessoa : AppBasePage
{
    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        ((MasterPages_Consulta)Master).Titulo = "Consulta de Pessoas";
        txtPesquisa.Focus();

        if (!IsPostBack)
        {
            Consultar("", "");
        }
    }

    protected void btnNovo_Click(object sender, EventArgs e)
    {
        Response.Redirect("CadPessoa?ACAO=Novo");
    }

    protected void btnConsultar_Click(object sender, EventArgs e)
    {
        string tipoConsulta = ddlPSQ.SelectedValue;
        string descricao = txtPesquisa.Text.Trim();
        Consultar(tipoConsulta, descricao);
    }

    protected void gvPessoas_ItemCreated(object sender, DataGridItemEventArgs e)
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

    protected void gvPessoas_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            e.Item.CssClass = "data-row";
        }
    }

    protected void gvPessoas_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "editar")
        {
            Response.Redirect("CadPessoa?acao=Editar&id=" + e.Item.Cells[2].Text);
        }
        else if (e.CommandName == "excluir")
        {
            Response.Redirect("CadPessoa?acao=Excluir&id=" + e.Item.Cells[2].Text);
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

    protected void gvPessoas_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        gvPessoas.CurrentPageIndex = e.NewPageIndex;
        btnConsultar_Click(null, null);
    }
    #endregion Events

    #region Metodos
    private void Consultar(string tipoConsulta, string descricao)
    {
        PessoaController pessoaController = new PessoaController();
        List<PessoaModel> pessoas = pessoaController.ConsultarPessoas(tipoConsulta, descricao);

        if (pessoas == null || pessoas.Count == 0)
        {
            gvPessoas.Columns[0].Visible = false;
            gvPessoas.Columns[1].Visible = false;
            pessoas = new List<PessoaModel>
            {
                new PessoaModel { NOME = "Nenhum registro encontrado" }
            };
        }
        else
        {
            gvPessoas.Columns[0].Visible = true;
            gvPessoas.Columns[1].Visible = true;
        }

        // Ordena a lista de pessoas por nome
        pessoas.Sort((p1, p2) => p1.NOME.CompareTo(p2.NOME));

        gvPessoas.DataSource = pessoas;
        gvPessoas.DataBind();
    }

    [WebMethod]
    public static List<string> GetPessoas(string term)
    {
        PessoaController pessoaController = new PessoaController();
        List<PessoaModel> pessoas = pessoaController.ConsultarPessoas("0", term);


        List<string> nomes = new List<string>();
        foreach (var pessoa in pessoas)
        {
            nomes.Add(pessoa.NOME);
        }

        return nomes;
    }

    #endregion Metodos

}