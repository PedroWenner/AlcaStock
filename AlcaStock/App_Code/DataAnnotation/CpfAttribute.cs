using System;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace AlcaStock.Attributes
{
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
    public sealed class CpfAttribute : ValidationAttribute
    {
        public static bool IsValid(string valor)
        {
            if (string.IsNullOrWhiteSpace(valor))
            {
                return false; // Considera CPF vazio como inv�lido
            }

            valor = Regex.Replace(valor, @"[^\d]", "");

            // Verifica se o campo tem a quantidade de caracteres v�lidos
            if (valor.Length == 11)
            {
                return IsValidCpf(valor);
            }
            else if (valor.Length == 14)
            {
                return IsValidCnpj(valor);
            }

            return false;
        }

        private static bool IsValidCpf(string cpf)
        {
            // Verifica se todos os d�gitos s�o iguais (CPF inv�lido)
            if (new string(cpf[0], 11) == cpf)
            {
                return false;
            }

            // Calcula os d�gitos verificadores
            int[] multiplicadores1 = { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicadores2 = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            string tempCpf = cpf.Substring(0, 9);
            int soma = 0;

            for (int i = 0; i < 9; i++)
            {
                soma += int.Parse(tempCpf[i].ToString()) * multiplicadores1[i];
            }

            int resto = soma % 11;
            if (resto < 2)
            {
                resto = 0;
            }
            else
            {
                resto = 11 - resto;
            }

            string digito1 = resto.ToString();
            tempCpf += digito1;
            soma = 0;

            for (int i = 0; i < 10; i++)
            {
                soma += int.Parse(tempCpf[i].ToString()) * multiplicadores2[i];
            }

            resto = soma % 11;
            if (resto < 2)
            {
                resto = 0;
            }
            else
            {
                resto = 11 - resto;
            }

            string digito2 = resto.ToString();
            tempCpf += digito2;

            // Verifica se os d�gitos verificadores calculados correspondem aos d�gitos originais
            return cpf.EndsWith(digito1 + digito2);
        }

        private static bool IsValidCnpj(string cnpj)
        {
            // Verifica se o CNPJ tem 14 d�gitos
            if (cnpj.Length != 14)
            {
                return false;
            }

            // Calcula o primeiro d�gito verificador
            int[] multiplicadores1 = { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int soma = 0;

            for (int i = 0; i < 12; i++)
            {
                soma += int.Parse(cnpj[i].ToString()) * multiplicadores1[i];
            }

            int resto = soma % 11;
            int digito1 = resto < 2 ? 0 : 11 - resto;

            // Calcula o segundo d�gito verificador
            int[] multiplicadores2 = { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            soma = 0;

            for (int i = 0; i < 13; i++)
            {
                soma += int.Parse(cnpj[i].ToString()) * multiplicadores2[i];
            }

            resto = soma % 11;
            int digito2 = resto < 2 ? 0 : 11 - resto;

            // Verifica se os d�gitos verificadores calculados correspondem aos d�gitos originais
            return cnpj.EndsWith(digito1.ToString() + digito2.ToString());
        }
    }
}