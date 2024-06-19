using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Models;
using Produto.Models;

namespace Produto.Repositorios
{
    public class ArquivoProdutoRepositorio
    {
        private readonly string _connectionString;

        public ArquivoProdutoRepositorio()
        {
            _connectionString = Utilitarios.conStr;
        }

        public List<ArquivoProdutoModel> ConsultarArquivoProdutosPorId(int? produtoId)
        {
            List<ArquivoProdutoModel> arquivosProdutoModel = new List<ArquivoProdutoModel>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"SELECT * FROM ARQUIVOS_PRODUTOS WHERE PRODUTO_ID = @PRODUTO_ID";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@PRODUTO_ID", produtoId);

                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ArquivoProdutoModel arquivoProdutoModel = new ArquivoProdutoModel
                    {
                        ARQUIVO_PRODUTO_ID = int.Parse(reader["ARQUIVO_PRODUTO_ID"].ToString()),
                        PRODUTO_ID = int.Parse(reader["PRODUTO_ID"].ToString()),
                        NAME = reader["NAME"].ToString(),
                        DATA = Convert.ToDateTime(reader["DATA"]),
                        MIME = reader["MIME"].ToString(),
                        DADOS = reader["DADOS"] != DBNull.Value ? (byte[])reader["DADOS"] : null
                    };

                    arquivosProdutoModel.Add(arquivoProdutoModel);
                }
            }

            return arquivosProdutoModel;
        }

        public void SalvarImagem(ArquivoProdutoModel arquivoProduto)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = "INSERT INTO ARQUIVOS_PRODUTOS(PRODUTO_ID, NAME, DATA, MIME, DADOS) VALUES (@PESSOA_ID, @NAME, @DATA, @MIME, @DADOS)";
                SqlCommand cmd = new SqlCommand(query, connection);
                SqlParameter[] parms = GetSqlParameterArray(arquivoProduto);
                
                for (int i = 0; i <= parms.Length - 1; i++)
                {
                    cmd.Parameters.Add(parms[i]);
                }

                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void DeletarImagem(int? produtoId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"DELETE ARQUIVOS_PRODUTOS WHERE PRODUTO_ID = @PRODUTO_ID";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@PESSOA_ID", produtoId);

                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        #region Parameters

        public static SqlParameter[] GetSqlParameterArray()
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("ARQUIVO_PRODUTO_ID", DbType.Int32),
                new SqlParameter("PRODUTO_ID", DbType.Int32),
                new SqlParameter("NAME", DbType.String),
                new SqlParameter("DATA", DbType.DateTime),
                new SqlParameter("MIME", DbType.String),
                new SqlParameter("DADOS", DbType.Binary)
                
            };

            for (int i = 0; i <= parms.Length - 1; i++)
            {
                parms[i].Value = DBNull.Value;
            }

            return parms;
        }

        public static SqlParameter[] GetSqlParameterArray(ArquivoProdutoModel x)
        {
            SqlParameter[] parms = GetSqlParameterArray();

            if (x.ARQUIVO_PRODUTO_ID != null)
                parms[0].Value = x.ARQUIVO_PRODUTO_ID;

            if (x.PRODUTO_ID != null)
                parms[1].Value = x.PRODUTO_ID;

            if (x.NAME != null)
                parms[2].Value = x.NAME;

            if (x.DATA != null)
                parms[3].Value = x.DATA;

            if (x.MIME != null)
                parms[4].Value = x.MIME;

            if (x.DADOS != null)
                parms[5].Value = x.DADOS;

            return parms;
        }

        #endregion Parameters
    }
}