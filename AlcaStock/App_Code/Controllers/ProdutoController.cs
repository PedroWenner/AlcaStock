using Produto.Repositorios;
using Produto.Models;
using System.Collections.Generic;

namespace Alcastock.Controllers
{
    public class ProdutoController
    {
        private readonly ProdutoRepositorio _repositorio;
        private readonly ArquivoProdutoRepositorio _repositorioArquivoProduto;
        public ProdutoController()
        {
            _repositorio = new ProdutoRepositorio();
            _repositorioArquivoProduto = new ArquivoProdutoRepositorio();
        }

        public List<ProdutoModel> ConsultarProdutos(string tipoConsulta, string descricao)
        {
            List<ProdutoModel> produtos = _repositorio.Consultar(tipoConsulta, descricao);
            return produtos;
        }

        public List<ProdutoModel> ConsultarProdutoPorId(string produtoId)
        {
            List<ProdutoModel> produtos = _repositorio.ConsultarPorId(produtoId);
            return produtos;
        }

        public void SalvarProduto(ProdutoModel produto)
        {
            _repositorio.Salvar(produto);
        }

        public void ExcluirProduto(int produtoId)
        {
            _repositorio.Excluir(produtoId);
        }

        /* ARQUIVO PESSOAS */
        public void SalvarImagem(ArquivoProdutoModel arquivoProduto)
        {
            _repositorioArquivoProduto.SalvarImagem(arquivoProduto);
        }

        //public static List<ArquivoProdutoModel> ConsultarArquivoProdutoPorId(int? produtoId)
        //{
        //    List<ArquivoProdutoModel> arquivoProduto = _repositorioArquivoProduto.ConsultarArquivoProdutosPorId(produtoId);
        //    return arquivoProduto;
        //}

        public void DeletarImagem(int? produtoId)
        {
            _repositorioArquivoProduto.DeletarImagem(produtoId);
        }
    }
}