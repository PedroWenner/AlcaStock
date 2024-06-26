<%@ Page Language="C#" MasterPageFile="~/MasterPages/Pesquisa.master" AutoEventWireup="true" Culture="PT-BR"
    CodeFile="PesqPessoas.aspx.cs" Inherits="Paginas_Pessoa_PesqPessoas" Title="Pesquisa de Pessoas" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentFiltros" runat="server">
    <script type="text/javascript">
        document.body.scroll = 'no';

        function refreshParent() {
            window.opener.location.reload(true);
            window.close();
        }
    </script>
</asp:Content>