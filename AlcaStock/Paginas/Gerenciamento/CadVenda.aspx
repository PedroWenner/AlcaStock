<%@ Page Language="C#" MasterPageFile="~/MasterPages/Cadastro.master" AutoEventWireup="true" CodeFile="CadVenda.aspx.cs" 
    Inherits="Paginas_Produto_CadVenda" Title="Cadastro de Vendas" EnableEventValidation="false" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI.ButtonToolBar" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc3" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.PopUp" TagPrefix="cc5" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentCampos" runat="server">    

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

            window.open(url, 'searchWindow', params);
        }

        function clearTextBox() {
            document.getElementById('<%= txtPessoaId.ClientID %>').value = '';
        }
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
            <div class="tab-content">
                <div class="tab-pane fade show active" id="produtoServico" role="tabpanel" aria-labelledby="produtoServicoTab">
                    <br />
                    <table width="100%">
                        <tr>
                            <td colspan="6">
                                <div class="input-group input-group-sm mb-3">
                                    <asp:TextBox ID="txtPessoaId" runat="server" Width="500px" CssClass="form-control form-control-sm" Enabled="false" />
                                    <button class="btn btn-outline-secondary" type="button" onclick="openSearchWindow()">
                                        <i class="fas fa-search"></i>
                                    </button>
                                    <button class="btn btn-outline-secondary" type="button" onclick="clearTextBox()">
                                        <i class="fas fa-eraser"></i>
                                    </button>
                                    <%--<input id="TextBox1" runat="server" Width="600px" placeholder="Digite o Nome ou CPF" class="form-control form-control-sm" aria-describedby="basic-addon2" />--%>
                                </div>
                                <%--<cc5:TextBoxButtonSearch ID="txtPessoaId" Width="550px" runat="server" CssClass="form-control form-control-sm"
                                    CssClassCaixaBotaoPesquisar="botaoPesquisar" Enabled="false" EnableBotoes="true"
                                    FunctionCallBackName="scriptCallBackEventoPensao" HeightPopUp="500" ParameterNameSearch="Parameters"
                                    ParameterValueSearch="null" Resizable="no" ToolTip="Consultar Eventos" UrlImageButton="../../Library/Images/Botoes/Lupa.gif"
                                    UrlImageButtonOver="../../Library/Images/Botoes/Lupa_S.gif" UrlPopUp="../Eventos/PesqEventos.aspx"
                                    UrlImageButtonEraser="../../Library/Images/Botoes/apagar_textbox.gif" UrlImageButtonEraserOver="../../Library/Images/Botoes/apagar_textbox_S.gif"
                                    WidthPopUp="700px">
                                </cc5:TextBoxButtonSearch>--%>
                                <%--<asp:TextBox ID="txtPessoaId" runat="server" Width="600px" placeholder="Digite o Nome ou CPF" CssClass="form-control form-control-sm" />--%>
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