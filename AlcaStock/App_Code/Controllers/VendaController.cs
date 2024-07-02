using Models;
using Produto.Models;
using Produto.Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Alcastock.Controllers
{
    /// <summary>
    /// Descrição resumida de VendaController
    /// </summary>
    public class VendaController
    {
        private readonly VendaRepositorio _repositorio;
        public VendaController()
        {
            _repositorio = new VendaRepositorio();
        }

        public List<VendasModel> ConsultarVendas(int pessoaId)
        {
            List<VendasModel> vendas = _repositorio.ConsultarVendas(pessoaId);
            return vendas;
        }
        public void Salvar(VendasModel venda)
        {
            _repositorio.Salvar(venda);
        }
    }
}
