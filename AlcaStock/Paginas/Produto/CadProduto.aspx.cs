using Produto.Models;
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

public partial class Paginas_Produto_CadProduto : AppBasePage
{
    #region Propiedades

    private string _ACAO = string.Empty;
    private string _ID = string.Empty;

    #endregion Propiedades

    protected void Page_Load(object sender, EventArgs e)
    {
        ((MasterPages_Cadastro)Master).Titulo = "Cadastro de Produto";
        divErros.Visible = false;

        if (Request.QueryString["acao"] != null)
            _ACAO = Request.QueryString["acao"].ToString();
        if (Request.QueryString["id"] != null)
            _ID = Request.QueryString["id"].ToString();

        if (_ACAO == "Excluir")
        {
            ExcluirProduto();
        }

        if (!IsPostBack)
        {
            chkControlaEstoque.Checked = false;
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
        Response.Redirect("/Paginas/Produto/ConProduto");
    }

    /// <summary>
    /// Ação do botão de salvar
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        ProdutoController produtoController = new ProdutoController();
        string erro = ValidaCampos();

        if (string.IsNullOrWhiteSpace(erro))
        {
            if (_ACAO == "Novo")
            {
                ProdutoModel produto = new ProdutoModel
                {
                    CODIGO = txtCodigo.Text,
                    TIPO = ddlTipo.SelectedValue,
                    NOME = txtNome.Text,
                    MARCA = int.Parse(ddlMarca.SelectedValue),
                    UNIDADE_MEDIDA = int.Parse(ddlUnidadeMedida.SelectedValue),
                    CUSTO = Convert.ToDecimal(txtCusto.Text),
                    PERC_LUCRO = Convert.ToDecimal(txtPercLucro.Text),
                    PRECO_VENDA = Convert.ToDecimal(hdnPrecoVenda.Value),
                    CONTROLA_ESTOQUE = Utilitarios.ConverteBoolParaSimNao(!chkControlaEstoque.Checked),
                    ESTOQUE_MININO = int.Parse(txtEstoqueMinimo.Text),
                    ATIVO = Utilitarios.ConverteBoolParaSimNao(!chkStatus.Checked),
                    SIS_USER_INSERT = "Pedro Wenner",
                    SIS_DATA_INSERT = DateTime.Now
                };

                produtoController.SalvarProduto(produto);

                Response.Cookies["MsgSucesso"].Value = "Produto adicionada com sucesso!";
            }
            else if (_ACAO == "Editar")
            {
                ProdutoModel produto = new ProdutoModel
                {
                    CODIGO = txtCodigo.Text,
                    TIPO = ddlTipo.SelectedValue,
                    NOME = txtNome.Text,
                    MARCA = int.Parse(ddlMarca.SelectedValue),
                    UNIDADE_MEDIDA = int.Parse(ddlUnidadeMedida.SelectedValue),
                    CUSTO = Convert.ToDecimal(txtCusto.Text),
                    PERC_LUCRO = Convert.ToDecimal(txtPercLucro.Text),
                    PRECO_VENDA = Convert.ToDecimal(hdnPrecoVenda.Value),
                    CONTROLA_ESTOQUE = Utilitarios.ConverteBoolParaSimNao(!chkControlaEstoque.Checked),
                    ESTOQUE_MININO = int.Parse(txtEstoqueMinimo.Text),
                    ATIVO = Utilitarios.ConverteBoolParaSimNao(!chkStatus.Checked),
                    SIS_USUARIO_UPDATE = "Pedro Wenner",
                    SIS_DATA_UPDATE = DateTime.Now
                };

                produtoController.AtualizarProduto(int.Parse(_ID), produto);
                Response.Cookies["MsgSucesso"].Value = "Produto atualizado com sucesso!";
            }

            // Após o salvamento bem-sucedido, define um cookie para indicar que o modal deve ser exibido
            Response.Cookies["Sucesso"].Value = "true";
            Response.Cookies["Sucesso"].Expires = DateTime.Now.AddSeconds(1); // Define o tempo de expiração do cookie
            Response.Cookies["MsgSucesso"].Expires = DateTime.Now.AddSeconds(1); // Define o tempo de expiração do cookie

            // Redireciona para a página de destino
            Response.Redirect("/Paginas/Produto/ConProduto");
        }
        else
        {
            divErros.Visible = true;
            lblErros.Text = erro;
        }
    }

    protected void btnInsereFoto_Click(object sender, EventArgs e)
    {
        if (_ACAO == "Editar")
        {
            if (fuFoto.HasFile)
            {
                if (fuFoto.FileName != string.Empty)
                {
                    // Obtem a extenção do arquivo
                    string extensao = Path.GetExtension(fuFoto.PostedFile.FileName).ToLower();

                    string tipoArquivo = null;
                    // Efetua a validação do arquivo
                    switch (extensao)
                    {
                        case ".gif":
                            tipoArquivo = "image/gif";
                            break;

                        case ".jpg":
                        case ".jpeg":
                            tipoArquivo = "image/jpeg";
                            break;

                        default:
                            ScriptManager.RegisterClientScriptBlock(this, GetType(), "msg", "<script>alert('Erro - tipo de arquivo inválido!');</script>", false);
                            return;
                    }

                    byte[] dados = new byte[fuFoto.PostedFile.InputStream.Length + 1];
                    fuFoto.PostedFile.InputStream.Read(dados, 0, dados.Length);

                    ArquivoProdutoModel arquivoProduto = new ArquivoProdutoModel
                    {
                        PRODUTO_ID = int.Parse(_ID),
                        NAME = fuFoto.PostedFile.FileName,
                        DATA = DateTime.Now,
                        MIME = fuFoto.PostedFile.ContentType,
                        DADOS = dados
                    };

                    SalvaFoto(arquivoProduto);
                }
            }
            else
            {
                divErros.Visible = true;
                lblErros.Text = "Favor informar a imagem que será anexada.";
            }
        }
    }

    protected void btnDeletaFoto_Click(object sender, EventArgs e)
    {
        ProdutoController produtoController = new ProdutoController();
        ProdutoModel produto = ConsultaProduto();
        produtoController.DeletarImagem(produto.PRODUTO_ID);

        ConsultaFoto();
    }

    #region Metodos
    private void ConfiguraTela()
    {
        txtCodigo.Text = Utilitarios.MaxID("CODIGO", "PRODUTOS").ToString();
        CarregaUnidadesMedidas();
        CarregaMarcas();

        if (_ACAO == "Editar")
        {
            //trImagem.Visible = true;
            //tdImagem.Visible = true;
            btnSalvar.Text = "<i class='fas fa-save'></i> Atualizar";
            PreencheCampos();
        }
    }

    private void CarregaUnidadesMedidas()
    {
        DataTable dt = Utilitarios.Pesquisar("SELECT * FROM fcUnidadesMedidas()");
        Utilitarios.AtualizaDropDown(ddlUnidadeMedida, dt, "NOME", "ID", "SELECIONE", "0");
    }

    private void CarregaMarcas()
    {
        DataTable dt = Utilitarios.Pesquisar("SELECT * FROM MARCAS");
        Utilitarios.AtualizaDropDown(ddlMarca, dt, "NOME", "ID", "SELECIONE", "0");
    }

    private string ValidaCampos()
    {
        string er = string.Empty;

        if (string.IsNullOrWhiteSpace(txtCodigo.Text))
            er += "<li>Campo código não pode ser vazio!</li>";
        if (string.IsNullOrWhiteSpace(txtNome.Text))
            er += "<li>Campo nome não pode ser vazio!</li>";
        //if (ddlGrupo.SelectedIndex == 0)
        //    er += "<li>Grupo deve ser preenchido</li>";
        //if (ddlMarca.SelectedIndex == 0)
        //    er += "<li>Grupo deve ser preenchido</li>";
        if (string.IsNullOrWhiteSpace(txtCusto.Text))
            er += "<li>Custo deve ser preenchido!</li>";
        //if (string.IsNullOrWhiteSpace(txtLucroEsperado.Text))
        //    er += "<li>Lucro esperado deve ser preenchido!</li>";
        if (string.IsNullOrWhiteSpace(txtEstoqueMinimo.Text))
            er += "<li>Estoque mínimo deve ser preenchido!</li>";

        return er;
    }

    private void PreencheCampos()
    {
        ProdutoController produtoController = new ProdutoController();
        ProdutoModel produto = ConsultaProduto();

        if (produto != null)
        {
            txtCodigo.Text = produto.CODIGO;
            ddlTipo.SelectedValue = produto.TIPO;
            txtNome.Text = produto.NOME;
            ddlMarca.SelectedValue = produto.MARCA.ToString();
            ddlUnidadeMedida.SelectedValue = produto.UNIDADE_MEDIDA.ToString();
            txtCusto.Text = produto.CUSTO.ToString();
            txtPercLucro.Text = produto.PERC_LUCRO.ToString();
            txtPrecoVenda.Text = produto.PRECO_VENDA.ToString();
            hdnPrecoVenda.Value = produto.PRECO_VENDA.ToString();
            chkStatus.Checked = !Utilitarios.ConverteSimNaoParaBool(produto.ATIVO);
            chkControlaEstoque.Checked = !Utilitarios.ConverteSimNaoParaBool(produto.CONTROLA_ESTOQUE);
            txtEstoqueMinimo.Text = produto.ESTOQUE_MININO.ToString();
            txtDataCadastro.Text = produto.SIS_DATA_INSERT.ToString();
            txtDataAtualizacao.Text = DateTime.Now.ToString("dd/MM/yyyy");

            ConsultaFoto();
        }
    }

    private ProdutoModel ConsultaProduto()
    {
        ProdutoController produtoController = new ProdutoController();
        List<ProdutoModel> produtos = produtoController.ConsultarProdutoPorId(_ID);

        ProdutoModel produto = produtos[0];
        return produto;
    }

    private void ConsultaFoto()
    {
        ProdutoController produtoController = new ProdutoController();
        ProdutoModel produto = ConsultaProduto();
        //List<ArquivoProdutoModel> arquivoProduto = ProdutoController.ConsultarArquivoProdutoPorId(produto.PRODUTO_ID);

        //if (arquivoProduto.Count > 0)
        //{
        //    imageFoto.Visible = true;
        //    imageFoto.ImageUrl = "MostraImagem.aspx?id=" + produto.PRODUTO_ID;
        //    btnDeletaFoto.Visible = true;
        //}
        //else
        //{
        //    imageFoto.Visible = false;
        //    btnDeletaFoto.Visible = false;
        //}
    }

    /// <summary>
    /// Método responsável para upload da foto da pessoa
    /// </summary>
    /// <param name="PESSOA_ID">PESSOA_ID, chave primaria da pessoa cadastrada</param>
    private void SalvaFoto(ArquivoProdutoModel arquivoProduto)
    {
        ProdutoController produtoController = new ProdutoController();
        produtoController.DeletarImagem(arquivoProduto.PRODUTO_ID);
        produtoController.SalvarImagem(arquivoProduto);

        ConsultaFoto();
    }

    private void ExcluirProduto()
    {
        ProdutoController p = new ProdutoController();

        p.ExcluirProduto(int.Parse(_ID));
        Response.Cookies["Sucesso"].Value = "true";
        Response.Cookies["Sucesso"].Expires = DateTime.Now.AddSeconds(1); // Define o tempo de expiração do cookie
        Response.Cookies["MsgSucesso"].Value = "Produto deletado com sucesso!";
        Response.Cookies["MsgSucesso"].Expires = DateTime.Now.AddSeconds(1); // Define o tempo de expiração do cookie

        // Redireciona para a página de destino
        Response.Redirect("/Produto/ConProduto");
    }

    #endregion Metodos

}