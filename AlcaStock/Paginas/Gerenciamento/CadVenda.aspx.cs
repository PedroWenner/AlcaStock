﻿using Produto.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Alcastock.Controllers;
using System.Globalization;
using Alcastock.Repositorios;
using AlcaStock.Attributes;
using System.Xml.Linq;
using System.IO;
using System.Data;
using Models;
using System.Web.Services;

public partial class Paginas_Produto_CadVenda : AppBasePage
{
    #region Propiedades

    private string _ACAO = string.Empty;
    private string _ID = string.Empty;

    #endregion Propiedades

    protected void Page_Load(object sender, EventArgs e)
    {
        ((MasterPages_Cadastro)Master).Titulo = "Lançamento de Vendas";
        divErros.Visible = false;

        if (Request.QueryString["acao"] != null)
            _ACAO = Request.QueryString["acao"].ToString();
        if (Request.QueryString["id"] != null)
            _ID = Request.QueryString["id"].ToString();

        if (_ACAO == "Excluir")
        {
            //
        }

        if (!IsPostBack)
        {
            ConfiguraTela();
            Utilitarios.AtribuirFuncoesJava(this);
        }
    }

    /// <summary>
    /// Ação do click de voltar
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("../../Inicial");
    }

    /// <summary>
    /// Ação do botão de salvar
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        //
    }

    #region Metodos
    private void ConfiguraTela()
    {
        CarregarProdutos();
        if (_ACAO == "Editar")
        {
            //
        }
    }

    private void CarregarProdutos()
    {
        ProdutoController produtoController = new ProdutoController();
        List<ProdutoModel> produtos = produtoController.ConsultarProdutos("1", "");

        if (produtos == null || produtos.Count == 0)
        {
            produtos = new List<ProdutoModel>
            {
                new ProdutoModel { CODIGO = "Nenhum registro encontrado" }
            };
        }

        ddlProduto.DataSource = produtos;
        ddlProduto.DataTextField = "NOME";
        ddlProduto.DataValueField = "PRODUTO_ID";
        ddlProduto.DataBind();

        ddlProduto.Items.Insert(0, new ListItem("SELECIONE", ""));
    }

    private string ValidaCampos()
    {
        string erro = string.Empty;
        if (string.IsNullOrWhiteSpace(hdnPessoaId.Value))
            erro += "<li>Favor informar a pessoa.</li>";
        if (string.IsNullOrWhiteSpace(ddlProduto.SelectedValue))
            erro += "<li>Favor selecionar qual o produto a ser registrado.</li>";
        if (string.IsNullOrWhiteSpace(txtEstoqueMinimo.Text))
            erro += "<li>Favor informar a quantidade de produtos vendidos.</li>";
        else if (int.Parse(txtEstoqueMinimo.Text) <= 0)
            erro += "<li>Favor informar a quantidade de produtos vendidos.</li>";

        return erro;
    }

    #endregion Metodos

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        string erro = ValidaCampos();
        if (string.IsNullOrWhiteSpace(erro))
        {
            VendaController vendaController = new VendaController();
        }
        else
        {
            divErros.Visible = true;
            lblErros.Text = erro;
        }
    }
}