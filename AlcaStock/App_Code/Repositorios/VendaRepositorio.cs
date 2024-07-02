using Models;
using Produto.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
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

        public List<VendasModel> ConsultarVendas(int pessoaId)
        {
            List<VendasModel> vendas = new List<VendasModel>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"
                    SELECT V.VENDA_ID, P.NOME AS NOME_PESSOA, P.CPF, PR.NOME AS NOME_PRODUTO, P.PESSOA_ID, PR.PRODUTO_ID, V.QUANTIDADE
                    FROM VENDAS V
                    JOIN PESSOAS P ON P.PESSOA_ID = V.PESSOA_ID
                    JOIN PRODUTOS PR ON PR.PRODUTO_ID = V.PRODUTO_ID
                    WHERE 1=1 AND P.PESSOA_ID = @PESSOA_ID";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@PESSOA_ID", pessoaId);

                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    VendasModel venda = new VendasModel
                    {
                        VendaId = int.Parse(reader["VENDA_ID"].ToString())
                        , PessoaId = int.Parse(reader["PESSOA_ID"].ToString())
                        , ProdutoId = int.Parse(reader["PRODUTO_ID"].ToString())
                        , NomePessoa = reader["NOME_PESSOA"].ToString()
                        , CpfPessoa = reader["CPF"].ToString()
                        , NomeProduto = reader["NOME_PRODUTO"].ToString()
                        , Quantidade = int.Parse(reader["QUANTIDADE"].ToString())
                    };

                    vendas.Add(venda);
                }
            }

            return vendas;
        }

        /// <summary>
        /// Método para salvar as vendas
        /// </summary>
        /// <param name="venda">VendaModel</param>
        public void Salvar(VendasModel venda)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"SET DATEFORMAT DMY; INSERT INTO VENDAS (PESSOA_ID, PRODUTO_ID, QUANTIDADE, SIS_USUARIO_INSERT, SIS_DATA_INSERT) VALUES (@PESSOA_ID, @PRODUTO_ID, @QUANTIDADE, @SIS_USUARIO_INSERT, @SIS_DATA_INSERT)";

                SqlCommand cmd = new SqlCommand(query, connection);
                SqlParameter[] parms = GetSqlParameterArray(venda);
                for (int i = 0; i <= parms.Length - 1; i++)
                {
                    cmd.Parameters.Add(parms[i]);
                }

                string debugCommandText = GetDebugCommandText(cmd);
                Console.WriteLine(debugCommandText);

                connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                connection.Close();
            }
        }

        static string GetDebugCommandText(SqlCommand cmd)
        {
            StringBuilder commandText = new StringBuilder(cmd.CommandText);

            foreach (SqlParameter param in cmd.Parameters)
            {
                string placeholder = param.ParameterName;
                string value;

                if (param.Value == DBNull.Value)
                {
                    value = "NULL";
                }
                else if (param.Value is string || param.Value is DateTime)
                {
                    value = "'" + param.Value.ToString() + "'";
                }
                else
                {
                    value = param.Value.ToString();
                }

                commandText.Replace(placeholder, value);
            }

            return commandText.ToString();
        }

        #region parametros

        public static SqlParameter[] GetSqlParameterArray()
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("PRODUTO_ID", DbType.Int32),
                new SqlParameter("QUANTIDADE", DbType.Int32),
                new SqlParameter("SIS_USUARIO_INSERT",DbType.String),
                new SqlParameter("SIS_USUARIO_UPDATE",DbType.String),
                new SqlParameter("SIS_DATA_UPDATE",DbType.DateTime),
                new SqlParameter("PESSOA_ID",DbType.Int32),
                new SqlParameter("SIS_DATA_INSERT",DbType.DateTime)
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

            if (x.SisDataInsert != null)
                parms[6].Value = x.SisDataInsert;

            return parms;
        }
        #endregion parametros
    }
}