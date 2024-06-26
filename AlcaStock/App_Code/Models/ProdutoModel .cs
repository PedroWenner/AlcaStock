using System;

namespace Produto.Models
{
    public class ProdutoModel
    {
        private int? _PRODUTO_ID;
        
        private string _CODIGO;
        private string _TIPO;
        private string _NOME;
        private string _NOME_UNIDADE_MEDIDA;
        private string _NOME_MARCA;
        private int? _GRUPO;
        private int? _MARCA;
        private int? _UNIDADE_MEDIDA;
        private decimal _CUSTO;
        private decimal _LUCRO_ESPERADO;
        private decimal _PERC_LUCRO;
        private decimal _PRECO_VENDA;
        private string _CONTROLA_ESTOQUE;
        private int? _ESTOQUE_MININO;
        private int? _ESTOQUE_ATUAL;
        private string _ATIVO;
        private string _SIS_USER_INSERT;
        private DateTime? _SIS_DATA_INSERT;
        private string _SIS_USUARIO_UPDATE;
        private DateTime? _SIS_DATA_UPDATE;


        public int? PRODUTO_ID
        {
            get { return _PRODUTO_ID; }
            set { _PRODUTO_ID = value; }
        }
        public string CODIGO
        {
            get { return _CODIGO; }
            set { _CODIGO = value; }
        }
        public string TIPO
        {
            get { return _TIPO; }
            set { _TIPO = value; }
        }
        public string NOME
        {
            get { return _NOME; }
            set { _NOME = value; }
        }
        public string NOME_UNIDADE_MEDIDA
        {
            get { return _NOME_UNIDADE_MEDIDA; }
            set { _NOME_UNIDADE_MEDIDA = value; }
        }
        public string NOME_MARCA
        {
            get { return _NOME_MARCA; }
            set { _NOME_MARCA = value; }
        }
        public int? GRUPO
        {
            get { return _GRUPO; }
            set { _GRUPO = value; }
        }
        public int? MARCA
        {
            get { return _MARCA; }
            set { _MARCA = value; }
        }
        public int? UNIDADE_MEDIDA
        {
            get { return _UNIDADE_MEDIDA; }
            set { _UNIDADE_MEDIDA = value; }
        }
        public decimal CUSTO
        {
            get { return _CUSTO; }
            set { _CUSTO = value; }
        }
        public decimal LUCRO_ESPERADO
        {
            get { return _LUCRO_ESPERADO; }
            set { _LUCRO_ESPERADO = value; }
        }
        public decimal PERC_LUCRO
        {
            get { return _PERC_LUCRO; }
            set { _PERC_LUCRO = value; }
        }
        public decimal PRECO_VENDA
        {
            get { return _PRECO_VENDA; }
            set { _PRECO_VENDA = value; }
        }
        public string CONTROLA_ESTOQUE
        {
            get { return _CONTROLA_ESTOQUE; }
            set { _CONTROLA_ESTOQUE = value; }
        }
        public int? ESTOQUE_MININO
        {
            get { return _ESTOQUE_MININO; }
            set { _ESTOQUE_MININO = value; }
        }
        public int? ESTOQUE_ATUAL
        {
            get { return _ESTOQUE_ATUAL; }
            set { _ESTOQUE_ATUAL = value; }
        }
        public string ATIVO
        {
            get { return _ATIVO; }
            set { _ATIVO = value; }
        }
        public string SIS_USER_INSERT
        {
            get { return _SIS_USER_INSERT; }
            set { _SIS_USER_INSERT = value; }
        }
        public DateTime? SIS_DATA_INSERT
        {
            get { return _SIS_DATA_INSERT; }
            set { _SIS_DATA_INSERT = value; }
        }
        public string SIS_USUARIO_UPDATE
        {
            get { return _SIS_USUARIO_UPDATE; }
            set { _SIS_USUARIO_UPDATE = value; }
        }
        public DateTime? SIS_DATA_UPDATE
        {
            get { return _SIS_DATA_UPDATE; }
            set { _SIS_DATA_UPDATE = value; }
        }
    }
}