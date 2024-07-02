<%@ Page Language="C#" MasterPageFile="~/MasterPages/Cadastro.master" AutoEventWireup="true" CodeFile="CadVenda.aspx.cs" 
    Inherits="Paginas_Produto_CadVenda" Title="Cadastro de Vendas" EnableEventValidation="false" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI.ButtonToolBar" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc3" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.PopUp" TagPrefix="cc5" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentCampos" runat="server">    
    <asp:UpdatePanel runat="server" ID="pnlContent">
        <ContentTemplate>
            <script type="text/javascript">
                function openSearchWindow() {
                    var url = '../Pessoa/PesqPessoas.aspx';
                    var width = 700;
                    var height = 500;
                    var left = (screen.width - width) / 2;
                    var top = (screen.height - height) / 2;
                    var params = 'width=' + width + ', height=' + height;
                    params += ', top=' + top + ', left=' + left;
                    params += ', resizable=no';

                    var searchWindow = window.open(url, 'searchWindow', params);

                    window.searchWindowCallback = function (retorno) {
                        if (retorno) {

                            var pessoaId = retorno.value;
                            // Concatena CPF com Nome da pessoa selecionada
                            var cpfNome = retorno.cpf + ' - ' + retorno.text;

                            document.getElementById('<%= txtPessoaId.ClientID %>').value = cpfNome;
                            document.getElementById('<%= hdnPessoaId.ClientID %>').value = pessoaId;
                            document.getElementById('<%= txtPessoaNome.ClientID %>').value = retorno.text;
                            document.getElementById('<%= txtPessoaEmail.ClientID %>').value = retorno.email;
                            document.getElementById('<%= txtPessoaCpf.ClientID %>').value = retorno.cpf;

                            document.getElementById('<%=btnConsultarVendas.ClientID %>').click();

                        }
                    };
                }

                function clearTextBox() {
                    document.getElementById('<%= txtPessoaId.ClientID %>').value = '';
                    document.getElementById('<%= hdnPessoaId.ClientID %>').value = '';
                    document.getElementById('<%= txtPessoaNome.ClientID %>').value = '';
                    document.getElementById('<%= txtPessoaEmail.ClientID %>').value = '';
                    document.getElementById('<%= txtPessoaCpf.ClientID %>').value = '';

                    document.getElementById('<%=btnConsultarVendas.ClientID %>').click();
                }

                $(document).ready(function () {

                    // Usar delegação de eventos para garantir que o evento continue funcionando após postbacks
                    $(document).on('change', '#<%= ddlProduto.ClientID %>', function () {
                        var selectedProductId = $(this).val();

                        // Chamada AJAX para o método WebService
                        $.ajax({
                            type: "POST",
                            url: "../../WebService/WebService.asmx/GetProductBalance",
                            data: JSON.stringify({ productId: selectedProductId }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                $('#<%= txtSaldoAtual.ClientID %>').val(response.d);
                            },
                            error: function (xhr, status, error) {
                                console.log("Erro ao obter saldo do produto:", error);
                            }
                        });
                    });

                    $(document).on('click', '#mais', function () {
                        var quantity = parseInt($('#<%= txtEstoqueMinimo.ClientID %>').val());
                        var saldoAtual = parseInt($('#<%= txtSaldoAtual.ClientID %>').val());

                        if (saldoAtual > 0) {
                            $('#<%= txtEstoqueMinimo.ClientID %>').val(quantity + 1);
                            $('#<%= txtSaldoAtual.ClientID %>').val(saldoAtual - 1);
                        }
                    });

                    $(document).on('click', '#menos', function () {
                        var quantity = parseInt($('#<%= txtEstoqueMinimo.ClientID %>').val());
                        var saldoAtual = parseInt($('#<%= txtSaldoAtual.ClientID %>').val());

                        if (quantity > 0) {
                            $('#<%= txtEstoqueMinimo.ClientID %>').val(quantity - 1);
                            $('#<%= txtSaldoAtual.ClientID %>').val(saldoAtual + 1);
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
                <div style="height: auto; width: 100%; min-height: 500px;">
                    <br />
                    <table width="100%">
                        <tr>
                            <td colspan="6">
                                <div class="input-group input-group-sm mb-3" style="width: 600px;">
                                    <asp:TextBox ID="txtPessoaId" runat="server" Width="500px" CssClass="form-control form-control-sm" Enabled="false" />
                                    <button class="btn btn-outline-secondary" type="button" onclick="openSearchWindow()">
                                        <i class="fas fa-search"></i>
                                    </button>
                                    <button class="btn btn-outline-secondary" type="button" onclick="clearTextBox()">
                                        <i class="fas fa-eraser"></i>
                                    </button>
                                </div>
                                <asp:HiddenField ID="hdnPessoaId" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaNome" runat="server" Width="600px" ValueField="Nome do Cliente" CssClass="form-control form-control-sm" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaEmail" runat="server" Width="600px" ValueField="E-mail" CssClass="form-control form-control-sm" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaCpf" runat="server" Width="600px" ValueField="CPF" CssClass="form-control form-control-sm" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <h4 class="rotuloTitulo">
                                    Lista de Produtos
                                </h4>
                                <hr>
                                <table>
                                    <tr>
                                        <td class="pr-2">
                                            <b class="rotulo">Código ou nome do Produto</b><br />
                                            <asp:DropDownList runat="server" ID="ddlProduto" CausesValidation="false" Width="350px" />
                                        </td>
                                        <td class="pr-2">
                                            <b class="rotulo">Saldo Atual</b><br />
                                            <asp:TextBox ID="txtSaldoAtual" runat="server" Width="80px" Enabled="false" CssClass="form-control form-control-sm" />
                                        </td>
                                        <td class="pr-2">
                                            <label class="rotulo">Quantidade</label><br />
                                            <button class="quantidade-btn" id="menos" type="button">-</button>
                                            <asp:TextBox ID="txtEstoqueMinimo" runat="server" CssClass="quantidade" Text="0" />
                                            <button class="quantidade-btn" id="mais" type="button">+</button>
                                        </td>
                                        <td valign="bottom">
                                            <asp:Button ID="btnRegistrar" runat="server" Width="150px" Text="Registrar" CssClass="btn btn-sm btn-outline-primary" OnClick="btnRegistrar_Click" />
                                            <asp:Button ID="btnConsultarVendas" runat="server" Width="150px" OnClick="btnConsultarVendas_Click" style="display: none;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="left">
                                <br />
                                <asp:DataGrid ID="grdVendas" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless custom-gridview"
                                    OnItemCreated="grdVendas_ItemCreated" OnItemDataBound="grdVendas_ItemDataBound" Width="50%">
                                    <Columns>
                                        <asp:BoundColumn DataField="VendaId" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="ProdutoId" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="PessoaId" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="NomePessoa" HeaderText="NOME" Visible="false" HeaderStyle-Width="40%"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="CpfPessoa" HeaderText="CPF" Visible="false" HeaderStyle-Width="20%"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="NomeProduto" HeaderText="PRODUTO" HeaderStyle-Width="50%"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Quantidade" HeaderText="QUANTIDADE" HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentToolBar" runat="Server">
    <asp:LinkButton ID="btnVoltar" Text="<i class='fas fa-arrow-alt-circle-left'></i> Voltar" runat="server" CssClass="btn btn-sm btn-secondary" CausesValidation="true"
        OnClick="btnVoltar_Click"/>
    <asp:LinkButton ID="btnSalvar" Text="<i class='fas fa-save'></i> Salvar" runat="server" CssClass="btn btn-sm btn-primary" CausesValidation="true"
        ToolTip="Clique aqui para salvar" OnClick="btnSalvar_Click" />
</asp:Content>