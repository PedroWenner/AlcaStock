<%@ Page Language="C#" MasterPageFile="~/MasterPages/Cadastro.master" AutoEventWireup="true" CodeFile="CadProduto.aspx.cs" 
    Inherits="Paginas_Produto_CadProduto" Title="Cadastro de Produto" EnableEventValidation="false" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI.ButtonToolBar" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc3" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentCampos" runat="server">

    <script type="text/javascript">
        function calculaPrecoVenda() {
            // Obtém os valores dos campos de entrada
            var txtCusto = document.getElementById('<%= txtCusto.ClientID %>').value;
            var txtPercLucro = document.getElementById('<%= txtPercLucro.ClientID %>').value;

            // Converte os valores para números
            var custo = parseFloat(txtCusto.replace('.', '').replace(',', '.'));
            var percLucro = parseFloat(txtPercLucro.replace('.', '').replace(',', '.'));

            if (isNaN(custo)) {
                custo = 0;
            }

            if (isNaN(percLucro)) {
                percLucro = 0;
            }

            // Calcula o preço de venda
            var precoVenda = custo + (custo * (percLucro / 100));

            if (isNaN(precoVenda)) {
                precoVenda = 0;
            }

            // Exibe o preço de venda no campo correspondente
            document.getElementById('<%= txtPrecoVenda.ClientID %>').value = precoVenda.toFixed(2).replace('.', ',');
            document.getElementById('<%= hdnPrecoVenda.ClientID %>').value = precoVenda.toFixed(2).replace('.', ',');

            calculaLiquido();
        }

        function calculaLiquido() {
            var txtPrecoVenda = document.getElementById('<%= txtPrecoVenda.ClientID %>').value;
            var txtCusto = document.getElementById('<%= txtCusto.ClientID %>').value;

            // Converte os valores para números
            var custo = parseFloat(txtCusto.replace('.', '').replace(',', '.'));
            var precoVenda = parseFloat(txtPrecoVenda.replace('.', '').replace(',', '.'));

            if (isNaN(custo)) {
                custo = 0;
            }

            if (isNaN(precoVenda)) {
                precoVenda = 0;
            }

            var precoLiquido = precoVenda - custo;
            if (isNaN(precoLiquido)) {
                precoLiquido = 0;
            }

            document.getElementById('<%= txtLiquido.ClientID %>').value = precoLiquido.toFixed(2).replace('.', ',');
        }

        $(document).ready(function () {
            $(document).ready(function () {
                // Função para formatar a data como dd/MM/yyyy
                function formatDate(date) {
                    var day = ("0" + date.getDate()).slice(-2);
                    var month = ("0" + (date.getMonth() + 1)).slice(-2);
                    var year = date.getFullYear();
                    return day + "/" + month + "/" + year;
                }

                var timeNow = new Date();
                var formattedDate = formatDate(timeNow);
                document.getElementById('<%= txtDataCadastro.ClientID %>').value = formattedDate;
                console.log(timeNow);
            });
        });

        $(document).ready(function () {
            $('#mais').click(function () {
                var quantity = parseInt(document.getElementById('<%= txtEstoqueMinimo.ClientID %>').value);
                //var quantity = parseInt($('#quantity').val());
                //$('#quantity').val(quantity + 1);
                document.getElementById('<%= txtEstoqueMinimo.ClientID %>').value = quantity + 1;
            });

            $('#menos').click(function () {
                var quantity = parseInt(document.getElementById('<%= txtEstoqueMinimo.ClientID %>').value);
                //var quantity = parseInt($('#quantity').val());
                if (quantity > 0) {
                    document.getElementById('<%= txtEstoqueMinimo.ClientID %>').value = quantity - 1;
                    //$('#quantity').val(quantity - 1);
                }
            });
        });
    </script>

    <div class="alert alert-danger alert-dismissible fade show" role="alert" runat="server" id="divErros" visible="false">
        <strong>Atenção!</strong>
        <ul>
            <asp:Label runat="server" ID="lblErros" />
        </ul>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div style="display: flex; align-content: center; justify-content: left; margin: 0;">
        <div style="height: 500px;">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="produtoServicoTab" data-toggle="tab" data-target="#produtoServico" type="button" role="tab" aria-controls="produtoServico" aria-selected="true">Produto ou Serviço</button>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="produtoServico" role="tabpanel" aria-labelledby="produtoServicoTab">
                    <br />
                    <table width="100%">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="pdr-10">
                                            <label class="rotulo">Código</label>
                                            <asp:TextBox ID="txtCodigo" runat="server" Width="150px" CssClass="form-control form-control-sm" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Tipo</label>
                                            <asp:DropDownList ID="ddlTipo" runat="server" ValueField="Tipo" Obrigatorio="true" Width="150px">
                                                <asp:ListItem Text="SELECIONE" Value="0" />
                                                <asp:ListItem Text="PRODUTO" Value="1" />
                                                <asp:ListItem Text="SERVIÇO" Value="2" />
                                            </asp:DropDownList>
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Nome</label>
                                            <asp:TextBox ID="txtNome" runat="server" onkeyup="convertToUppercase(event);" Width="600px" Style="padding: 5px;" CssClass="form-control form-control-sm" />                         
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" rowspan="9" runat="server" id="tdImagem" visible="false">
                                <asp:Image ID="imageFoto" Height="200px" Width="150px" runat="server" Visible="false" BorderColor="#CCCCCC"
                                    BorderWidth="1px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="pdr-10">
                                            <label class="rotulo">Marca</label>
                                            <asp:DropDownList ID="ddlMarca" runat="server" Obrigatorio="true" Width="300px" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Unid. medida</label>
                                            <asp:DropDownList ID="ddlUnidadeMedida" runat="server" Obrigatorio="true" Width="300px" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="pdr-10">
                                            <label class="rotulo">Custo (R$)</label>
                                            <asp:TextBox ID="txtCusto" runat="server" Width="150px" CssClass="form-control form-control-sm money" onblur="calculaPrecoVenda();" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Perc. Lucro (%)</label>
                                            <asp:TextBox ID="txtPercLucro" runat="server" Width="150px" CssClass="form-control form-control-sm perc" onblur="calculaPrecoVenda();" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Preço Venda (R$)</label>
                                            <asp:TextBox ID="txtPrecoVenda" runat="server" Width="150px" CssClass="form-control form-control-sm money" Enabled="false" />
                                            <asp:HiddenField ID="hdnPrecoVenda" runat="server" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Líquido (R$)</label>
                                            <asp:TextBox ID="txtLiquido" runat="server" Width="150px" CssClass="form-control form-control-sm money" Enabled="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="pdr-10">
                                            <label class="rotulo">Controla Estoque</label><br />
                                            <div class="toggle-btn">
                                                <div class="btn-switch botao1 radius">
                                                    <input type="checkbox" class="checkbox" id="chkControlaEstoque" runat="server" />
                                                    <div class="on"></div>
                                                    <div class="off"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Quantidade</label><br />
                                            <button class="quantidade-btn" id="menos" type="button">-</button>
                                            <asp:TextBox ID="txtEstoqueMinimo" runat="server" CssClass="quantidade" Text="0" />
                                            <button class="quantidade-btn" id="mais" type="button">+</button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="50%">
                                    <tr>
                                        <td class="pdr-10">
                                            <label class="rotulo">Ativo</label><br />
                                            <div class="toggle-btn">
                                                <div class="btn-switch botao1 radius">
                                                    <input type="checkbox" class="checkbox" id="chkStatus" runat="server" />
                                                    <div class="on"></div>
                                                    <div class="off"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="pdr-10">
                                            <asp:Label runat="server" Font-Bold="true" CssClass="rotulo">Data Cadastro</asp:Label>
                                            <asp:TextBox ID="txtDataCadastro" runat="server" Width="100px" CssClass="date form-control form-control-sm" MaxLength="10" Enabled="false" />
                                        </td>
                                        <td class="pdr-10">
                                            <label class="rotulo">Data Atualização</label>
                                            <asp:TextBox ID="txtDataAtualizacao" runat="server" Width="100px" CssClass="date form-control form-control-sm" MaxLength="10" Enabled="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server" id="trImagem" visible="false">
                            <td>
                                <table>
                                    <tr>
                                        <td class="pdr-10">
                                            <b class="rotulo">Selecione o arquivo da Foto:</b><br />
                                            <asp:FileUpload ID="fuFoto" Width="300px" runat="server" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnInsereFoto" Text="Inserir foto" runat="server" CssClass="btn btn-sm btn-outline-primary btn-pequeno"
                                                OnClick="btnInsereFoto_Click"/>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnDeletaFoto" Text="Excluir foto" runat="server" CssClass="btn btn-sm btn-outline-danger btn-pequeno"
                                                OnClick="btnDeletaFoto_Click"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentToolBar" runat="Server">
    <asp:LinkButton ID="btnVoltar" Text="<i class='fas fa-arrow-alt-circle-left'></i> Voltar" runat="server" CssClass="btn btn-sm btn-secondary" CausesValidation="true"
        OnClick="btnVoltar_Click"/>
    <asp:LinkButton ID="btnSalvar" Text="<i class='fas fa-save'></i> Salvar" runat="server" CssClass="btn btn-sm btn-primary" CausesValidation="true"
        ToolTip="Clique aqui para salvar" OnClick="btnSalvar_Click" />
</asp:Content>