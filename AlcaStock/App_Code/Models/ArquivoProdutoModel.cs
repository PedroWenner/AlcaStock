using System;

namespace Produto.Models
{
    public class ArquivoProdutoModel
    {
        private int? _ARQUIVO_PRODUTO_ID;
        private int? _PRODUTO_ID;
        private string _NAME;
        private DateTime? _DATA;
        private string _MIME;
        private byte[] _DADOS;

        public int? ARQUIVO_PRODUTO_ID
        {
            get { return _ARQUIVO_PRODUTO_ID; }
            set { _ARQUIVO_PRODUTO_ID = value; }
        }
        public int? PRODUTO_ID
        {
            get { return _PRODUTO_ID; }
            set { _PRODUTO_ID = value; }
        }
        public string NAME
        {
            get { return _NAME; }
            set { _NAME = value; }
        }
        public DateTime? DATA
        {
            get { return _DATA; }
            set { _DATA = value; }
        }
        public string MIME
        {
            get { return _MIME; }
            set { _MIME = value; }
        }
        public byte[] DADOS
        {
            get { return _DADOS; }
            set { _DADOS = value; }
        }
    }
}