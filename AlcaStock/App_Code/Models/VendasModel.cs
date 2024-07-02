using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Models
{
    public class VendasModel
    {
        private int _vendaId;
        private int _pessoaId;
        private int _produtoId;
        private int _quantidade;
        private string _nomePessoa;
        private string _cpfPessoa;
        private string _nomeProduto;
        private string _sisUsuarioInsert;
        private DateTime _sisDataInsert;
        private string _sisUsuarioUpdate;
        private DateTime? _sisDataUpdate;

        public int VendaId
        {
            get { return _vendaId; }
            set { _vendaId = value; }
        }

        public int PessoaId
        {
            get { return _pessoaId; }
            set { _pessoaId = value; }
        }

        public int ProdutoId
        {
            get { return _produtoId; }
            set { _produtoId = value; }
        }

        public int Quantidade
        {
            get { return _quantidade; }
            set { _quantidade = value; }
        }

        public string NomePessoa
        {
            get { return _nomePessoa; }
            set { _nomePessoa = value; }
        }

        public string CpfPessoa
        {
            get { return _cpfPessoa; }
            set { _cpfPessoa = value; }
        }

        public string NomeProduto
        {
            get { return _nomeProduto; }
            set { _nomeProduto = value; }
        }

        public string SisUsuarioInsert
        {
            get { return _sisUsuarioInsert; }
            set { _sisUsuarioInsert = value; }
        }

        public DateTime SisDataInsert
        {
            get { return _sisDataInsert; }
            set { _sisDataInsert = value; }
        }

        public string SisUsuarioUpdate
        {
            get { return _sisUsuarioUpdate; }
            set { _sisUsuarioUpdate = value; }
        }

        public DateTime? SisDataUpdate
        {
            get { return _sisDataUpdate; }
            set { _sisDataUpdate = value; }
        }
    }
}