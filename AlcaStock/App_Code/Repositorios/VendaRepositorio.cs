﻿using Models;
using Produto.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Produto.Repositorios
{
    /// <summary>
    /// Descrição resumida de VendaRepositorio
    /// </summary>
    public class VendaRepositorio
    {
        private readonly string _connectionString;
        public VendaRepositorio()
        {
            _connectionString = Utilitarios.conStr;
        }

        /// <summary>
        /// Método para salvar as vendas
        /// </summary>
        /// <param name="venda">VendaModel</param>
        public void Salvar(VendasModel venda)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"INSERT INTO VENDAS (PESSOA_ID, PRODUTO_ID, QUANTIDADE, SIS_USUARIO_INSERT) VALUES (@PESSOA_ID, @PRODUTO_ID, @QUANTIDADE, @SIS_USUARIO_INSERT)";

                SqlCommand cmd = new SqlCommand(query, connection);
                SqlParameter[] parms = GetSqlParameterArray(venda);
                for (int i = 0; i <= parms.Length - 1; i++)
                {
                    cmd.Parameters.Add(parms[i]);
                }

                connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                connection.Close();
            }
        }



        #region parametros

        public static SqlParameter[] GetSqlParameterArray()
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("PRODUTO_ID", DbType.Int32),
                new SqlParameter("QUANTIDADE", DbType.Int32),
                new SqlParameter("SIS_USER_INSERT",DbType.String),
                new SqlParameter("SIS_USUARIO_UPDATE",DbType.String),
                new SqlParameter("SIS_DATA_UPDATE",DbType.DateTime),
                new SqlParameter("PESSOA_ID",DbType.Int32)
            };

            for (int i = 0; i <= parms.Length - 1; i++)
                parms[i].Value = DBNull.Value;

            return parms;
        }

        public static SqlParameter[] GetSqlParameterArray(VendasModel x)
        {
            SqlParameter[] parms = GetSqlParameterArray();
            if (x.ProdutoId != 0)
                parms[0].Value = x.ProdutoId;

            if (x.Quantidade != 0)
                parms[1].Value = x.Quantidade;

            if (x.SisUsuarioInsert != null)
                parms[2].Value = x.SisUsuarioInsert;

            if (x.SisUsuarioUpdate != null)
                parms[3].Value = x.SisUsuarioUpdate;

            if (x.SisDataUpdate != null)
                parms[4].Value = x.SisDataUpdate;

            if (x.PessoaId != 0)
                parms[5].Value = x.PessoaId;

            return parms;
        }
        #endregion parametros
    }
}