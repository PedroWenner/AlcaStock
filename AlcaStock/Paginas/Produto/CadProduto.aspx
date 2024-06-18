<%@ Page Language="C#" MasterPageFile="~/MasterPages/Cadastro.master" AutoEventWireup="true" CodeFile="CadProduto.aspx.cs" 
    Inherits="Paginas_Pessoa_CadProduto" Title="Cadastro de Produto" EnableEventValidation="false" %>

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

            calculaLiquido();

            // Log dos valores para depuração
            console.log('Custo:', custo);
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
            console.log('Preço Venda:', precoVenda);
            console.log('Preço Custo:', txtCusto);
            if (isNaN(precoLiquido)) {
                precoLiquido = 0;
            }

            document.getElementById('<%= txtLiquido.ClientID %>').value = precoLiquido.toFixed(2).replace('.', ',');

            // Log dos valores para depuração
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
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="enderecoTab" data-toggle="tab" data-target="#endereco" type="button" role="tab" aria-controls="endereco" aria-selected="false">Endereço</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="arquivosTab" data-toggle="tab" data-target="#arquivos" type="button" role="tab" aria-controls="arquivos" aria-selected="false" runat="server" visible="false">Documentos Anexados</button>
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
                                            <cc3:FieldTextBox ID="txtCodigo" runat="server" ValueField="Código" Width="150px" Style="padding: 5px;" />
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldDropDown ID="ddlTipo" runat="server" ValueField="Tipo" style="padding: 4px;" Width="150px" CssClass="input-cadastro">
                                                <asp:ListItem Text="Produto" Value="1" Selected="True" />
                                                <asp:ListItem Text="Serviço" Value="2" />
                                            </cc3:FieldDropDown>
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtNome" runat="server" onkeyup="convertToUppercase(event);" ValueField="Nome" Width="600px" Style="padding: 5px;" />                         
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
                                            <cc3:FieldDropDown ID="ddlGrupo" runat="server" ValueField="Grupo*" style="padding: 4px;" Width="310px" CssClass="input-cadastro">
                                                <asp:ListItem Text="Selecione" Value="0" Selected="True" />
                                            </cc3:FieldDropDown>
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldDropDown ID="ddlMarca" runat="server" ValueField="Marca" style="padding: 4px;" Width="295px" CssClass="input-cadastro">
                                                <asp:ListItem Text="Selecione" Value="0" Selected="True" />
                                            </cc3:FieldDropDown>
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtUnidadeMedida" runat="server" ValueField="Unid. medida" Width="295px" Style="padding: 5px;" />
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
                                            <cc3:FieldTextBox ID="txtCusto" runat="server" ValueField="Custo (R$)" Width="150px" CssClass="input-cadastro money" onblur="calculaPrecoVenda();" />
                                        </td>
                                        <%--<td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtLucroEsperado" runat="server" ValueField="Lucro Esperado (R$)" Width="150px" CssClass="input-cadastro money" />
                                        </td>--%>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtPercLucro" runat="server" ValueField="Perc. Lucro (%)" Width="150px" CssClass="input-cadastro perc" onblur="calculaPrecoVenda();" />
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtPrecoVenda" runat="server" ValueField="Preço Venda (R$)" Width="150px" CssClass="input-cadastro money" ReadOnly="true" />
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtLiquido" runat="server" ValueField="Líquido (R$)" Width="150px" CssClass="input-cadastro money" ReadOnly="true" />
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
                                            <%--<div class="quantity-container">
                                            </div>--%>
                                        </td>
                                        <td class="pdr-10">
                                            <cc3:FieldTextBox ID="txtEstoqueAtual" runat="server" ValueField="Estoque Atual" Width="150px" CssClass="input-cadastro" Enabled="false" />
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
                                            <div class="input-group">
                                                <cc3:FieldTextBox ID="txtDataCadastro" runat="server"
                                                    Style="width: 100px;" CssClass="date input-cadastro" MaxLength="10" Enabled="false" />
                                                <cc2:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDataCadastro"
                                                    Animated="true" Format="dd/MM/yyyy" />
                                            </div>
                                        </td>
                                        <td class="pdr-10">
                                            <asp:Label runat="server" Font-Bold="true" CssClass="rotulo">Data Atualização</asp:Label>
                                            <div class="input-group">
                                                <cc3:FieldTextBox ID="txtDataAtualizacao" runat="server"
                                                    Style="width: 100px;" CssClass="date input-cadastro" MaxLength="10" Enabled="false" />
                                            </div>
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
                <div class="tab-pane fade" id="endereco" role="tabpanel" aria-labelledby="enderecoTab">teste2</div>
                <div class="tab-pane fade" id="arquivos" role="tabpanel" aria-labelledby="arquivosTab" runat="server" visible="false">
                    <br />
                    <table width="100%">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="btnVisualizaDocs" Text="<i class='fas fa-file-image'></i> Visualizar Documentos" runat="server" CssClass="btn btn-sm btn-secondary btn-pequeno"/>
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