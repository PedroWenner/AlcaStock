﻿<%@ Page Language="C#" MasterPageFile="~/MasterPages/Pesquisa.master" AutoEventWireup="true" Culture="PT-BR"
    CodeFile="PesqPessoas.aspx.cs" Inherits="Paginas_Pessoa_PesqPessoas" Title="Pesquisa de Pessoas" %>

<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc1" %>
<%@ Register Assembly="AGENDA.Controles" Namespace="AGENDA.Controles.UI" TagPrefix="cc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentFiltros" runat="server">
    <script type="text/javascript">
        document.body.scroll = 'no';

        function refreshParent() {
            window.opener.location.reload(true);
            window.close();
        }
    </script>

    <asp:UpdatePanel ID="pnlFiltro" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-auto">
                    <cc2:FieldDropDown ID="ddlPSQ" runat="server" ValueField="Pesquisar por" CssClass="form-select form-select-sm" Width="150px">
                        <asp:ListItem Value="0">Nome</asp:ListItem>
                        <asp:ListItem Value="1">CPF</asp:ListItem>
                    </cc2:FieldDropDown>
                </div>
                <div class="col-auto">
                    <label class="rotuloCaixaPesquisar">Descrição</label>
                    <div class="input-group input-group-sm">
                        <cc2:FieldTextBox ID="txtPesquisa" runat="server" CssClass="form-control form-control-sm" Width="250px" onkeyup="convertToUppercase(event);" />
                    </div>
                </div>
                <div class="col-auto d-flex align-items-end">
                    <asp:Button ID="btnConsultar" Text="Consultar" runat="server" CssClass="btn btn-sm btn-outline-dark" OnClick="btnConsultar_Click"/>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentGrid" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:DataGrid ID="grdResultados" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless custom-gridview"
                OnItemCreated="grdResultados_ItemCreated" OnItemDataBound="grdResultados_ItemDataBound">
                <Columns>
                    <asp:BoundColumn DataField="PESSOA_ID" HeaderText="ID" Visible="false" />
                    <asp:BoundColumn DataField="NOME" HeaderText="Nome" />
                    <asp:BoundColumn DataField="CPF" HeaderText="CPF" />
                    <asp:BoundColumn DataField="DATA_NASC" HeaderText="Data de Nascimento" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>
            </asp:DataGrid>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>