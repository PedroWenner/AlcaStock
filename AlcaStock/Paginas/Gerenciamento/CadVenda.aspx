<%@ Page Language="C#" MasterPageFile="~/MasterPages/Cadastro.master" AutoEventWireup="true" CodeFile="CadVenda.aspx.cs" 
    Inherits="Paginas_Produto_CadVenda" Title="Cadastro de Vendas" EnableEventValidation="false" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI.ButtonToolBar" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc3" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentCampos" runat="server">

    <script type="text/javascript">

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
                            <td colspan="6" class="pdb-20">
                                <asp:TextBox ID="txtPessoaId" runat="server" Width="600px" placeholder="Digite o Nome ou CPF" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaNome" runat="server" Width="600px" ValueField="Nome do Cliente" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaEmail" runat="server" Width="600px" ValueField="E-mail" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="pdb-20">
                                <cc3:FieldTextBox ID="txtPessoaCpf" runat="server" Width="600px" ValueField="CPF" />
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