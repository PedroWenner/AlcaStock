using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Models;

namespace Alcastock.Repositorios
{
    public class ProdutoRepositorio
    {
        private readonly string _connectionString;

        public ProdutoRepositorio()
        {
            _connectionString = Utilitarios.conStr;
        }

        public List<PessoaModel> ConsultarPessoas(string tipoConsulta, string descricao)
        {
            List<PessoaModel> pessoas = new List<PessoaModel>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"
                SELECT CASE WHEN SEXO = 'M' THEN UPPER('Masculino') ELSE UPPER('Feminino') END AS SEXO, * 
                FROM PESSOAS
                WHERE 1=1";

                if (tipoConsulta == "0")
                    query += " AND NOME LIKE @DESCRICAO";
                else if (tipoConsulta == "1")
                    query += " AND CPF LIKE @DESCRICAO";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@DESCRICAO", "%" + descricao + "%");

                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    PessoaModel pessoa = new PessoaModel
                    {
                        PESSOA_ID = int.Parse(reader["PESSOA_ID"].ToString()),
                        NOME = reader["NOME"].ToString(),
                        CPF = reader["CPF"].ToString(),
                        DATA_NASC = Convert.ToDateTime(reader["DATA_NASC"]),
                        SEXO = reader["SEXO"].ToString(),
                        NOME_MAE = reader["NOME_MAE"].ToString(),
                        CPF_MAE = reader["CPF_MAE"].ToString(),
                        NOME_PAI = reader["NOME_PAI"].ToString(),
                        CPF_PAI = reader["CPF_PAI"].ToString(),
                        TELEFONE_RESIDENCIAL = reader["TELEFONE_RESIDENCIAL"].ToString(),
                        TELEFONE_CELULAR = reader["TELEFONE_CELULAR"].ToString(),
                        EMAIL = reader["EMAIL"].ToString()
                    };

                    pessoas.Add(pessoa);
                }
            }

            return pessoas;
        }

        public List<PessoaModel> ConsultarPessoaPorId(string pessoaId)
        {
            List<PessoaModel> pessoas = new List<PessoaModel>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"
                SELECT CASE WHEN SEXO = 'M' THEN UPPER('Masculino') ELSE UPPER('Feminino') END AS SEXO, * 
                FROM PESSOAS
                WHERE PESSOA_ID = @PESSOA_ID";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@PESSOA_ID", pessoaId);

                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    PessoaModel pessoa = new PessoaModel
                    {
                        PESSOA_ID = int.Parse(reader["PESSOA_ID"].ToString()),
                        NOME = reader["NOME"].ToString(),
                        CPF = reader["CPF"].ToString(),
                        DATA_NASC = Convert.ToDateTime(reader["DATA_NASC"]),
                        SEXO = reader["SEXO"].ToString(),
                        NOME_MAE = reader["NOME_MAE"].ToString(),
                        CPF_MAE = reader["CPF_MAE"].ToString(),
                        NOME_PAI = reader["NOME_PAI"].ToString(),
                        CPF_PAI = reader["CPF_PAI"].ToString(),
                        TELEFONE_RESIDENCIAL = reader["TELEFONE_RESIDENCIAL"].ToString(),
                        TELEFONE_CELULAR = reader["TELEFONE_CELULAR"].ToString(),
                        EMAIL = reader["EMAIL"].ToString()
                    };

                    pessoas.Add(pessoa);
                }
            }

            return pessoas;
        }

        /// <summary>
        /// M�todo para salvar a pessoa
        /// </summary>
        /// <param name="pessoa">Model PESSOAS</param>
        public void Salvar(PessoaModel pessoa)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"SET DATEFORMAT DMY; INSERT INTO PESSOAS (NOME, CPF, DATA_NASC, SEXO, NOME_MAE, CPF_MAE, NOME_PAI, CPF_PAI
                                , TELEFONE_RESIDENCIAL, TELEFONE_CELULAR, EMAIL, SIS_USUARIO_INSERT, SIS_DATA_INSERT)
                                VALUES (@NOME, @CPF, @DATA_NASC, @SEXO, @NOME_MAE, @CPF_MAE, @NOME_PAI, @CPF_PAI,
                                @TELEFONE_RESIDENCIAL, @TELEFONE_CELULAR, @EMAIL, @SIS_USUARIO_INSERT, @SIS_DATA_INSERT)";

                SqlCommand cmd = new SqlCommand(query, connection);
                SqlParameter[] parms = GetSqlParameterArray(pessoa);
                for (int i = 0; i <= parms.Length - 1; i++)
                {
                    cmd.Parameters.Add(parms[i]);
                }

                //string sqlDebug = query;
                //foreach (SqlParameter param in cmd.Parameters)
                //{
                //    sqlDebug = sqlDebug.Replace(param.ParameterName, param.Value.ToString());
                //}

                //// Registrar ou exibir a string SQL final para depura��o
                //System.Diagnostics.Debug.WriteLine(sqlDebug);

                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// M�todo para atualizar a pessoa
        /// </summary>
        /// <param name="pessoa">Model PESSOAS</param>
        public void AtualizarPessoa(int pessoaId, PessoaModel pessoa)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"
                    SET DATEFORMAT DMY;
                    UPDATE PESSOAS
                    SET NOME = @NOME, CPF = @CPF, DATA_NASC = @DATA_NASC, SEXO = @SEXO, NOME_MAE = @NOME_MAE,
                    CPF_MAE = @CPF_MAE, NOME_PAI = @NOME_PAI, CPF_PAI = @CPF_PAI, TELEFONE_RESIDENCIAL = @TELEFONE_RESIDENCIAL,
                    TELEFONE_CELULAR = @TELEFONE_CELULAR, EMAIL = @EMAIL, SIS_USUARIO_UPDATE = @SIS_USUARIO_UPDATE, SIS_DATA_UPDATE = @SIS_DATA_UPDATE
                    WHERE PESSOA_ID = @PESSOA_ID";

                SqlCommand cmd = new SqlCommand(query, connection);
                SqlParameter[] parms = GetSqlParameterArray(pessoa);
                for (int i = 0; i <= parms.Length - 1; i++)
                {
                    cmd.Parameters.Add(parms[i]);
                }

                cmd.Parameters.AddWithValue("@PESSOA_ID", pessoaId);

                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// M�todo para excluir a pessoa e suas dependencias
        /// </summary>
        /// <param name="pessoa">PESSOA_ID</param>
        public void ExcluirPessoa(int pessoaId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"
                    DELETE ARQUIVOS_PESSOAS WHERE PESSOA_ID = @PESSOA_ID;
                    DELETE PESSOAS WHERE PESSOA_ID = @PESSOA_ID;";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@PESSOA_ID", pessoaId);
                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        #region Parameters

        public static SqlParameter[] GetSqlParameterArray()
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("CPF", DbType.String),
                new SqlParameter("NOME", DbType.String),
                new SqlParameter("SEXO", DbType.String),
                new SqlParameter("DATA_NASC", DbType.DateTime),
                new SqlParameter("NOME_MAE", DbType.String),
                new SqlParameter("CPF_MAE", DbType.String),
                new SqlParameter("NOME_PAI", DbType.String),
                new SqlParameter("CPF_PAI", DbType.String),
                new SqlParameter("TELEFONE_RESIDENCIAL", DbType.String),
                new SqlParameter("TELEFONE_CELULAR",DbType.String),
                new SqlParameter("EMAIL",DbType.String),
                new SqlParameter("SIS_USUARIO_INSERT",DbType.String),
                new SqlParameter("SIS_DATA_INSERT",DbType.DateTime),
                new SqlParameter("SIS_USUARIO_UPDATE",DbType.String),
                new SqlParameter("SIS_DATA_UPDATE",DbType.DateTime)
            };

            for (int i = 0; i <= parms.Length - 1; i++)
            {
                parms[i].Value = DBNull.Value;
            }

            return parms;
        }

        public static SqlParameter[] GetSqlParameterArray(PessoaModel x)
        {
            SqlParameter[] parms = GetSqlParameterArray();

            if (x.CPF != null)
                parms[0].Value = x.CPF;

            if (x.NOME != null)
                parms[1].Value = x.NOME;

            if (x.SEXO != null)
                parms[2].Value = x.SEXO;

            if (x.DATA_NASC != null)
                parms[3].Value = x.DATA_NASC;

            if (x.NOME_MAE != null)
                parms[4].Value = x.NOME_MAE;

            if (x.CPF_MAE != null)
                parms[5].Value = x.CPF_MAE;

            if (x.NOME_PAI != null)
                parms[6].Value = x.NOME_PAI;

            if (x.CPF_PAI != null)
                parms[7].Value = x.CPF_PAI;

            if (x.TELEFONE_RESIDENCIAL != null)
                parms[8].Value = x.TELEFONE_RESIDENCIAL;

            if (x.TELEFONE_CELULAR != null)
                parms[9].Value = x.TELEFONE_CELULAR;

            if (x.EMAIL != null)
                parms[10].Value = x.EMAIL;

            if (x.SIS_USUARIO_INSERT != null)
                parms[11].Value = x.SIS_USUARIO_INSERT;

            if (x.SIS_DATA_INSERT != null)
                parms[12].Value = x.SIS_DATA_INSERT;

            if (x.SIS_USUARIO_UPDATE != null)
                parms[13].Value = x.SIS_USUARIO_UPDATE;

            if (x.SIS_DATA_UPDATE != null)
                parms[14].Value = x.SIS_DATA_UPDATE;

            return parms;
        }

        #endregion Parameters
    }
}