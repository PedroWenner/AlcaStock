using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;

/// <summary>
/// Cont�m fun��es utitil�rias para http.
/// </summary>
public static class HttpUtil
{
    /// <summary>
    /// Normaliza uma url trocando o caracter ~ pelo ApplicationPath.
    /// </summary>
    /// <param name="page">P�gina onde a url reside.</param>
    /// <param name="url">Url a ser normalizada.</param>
    /// <returns>Url normalizada.</returns>
    public static string NormalizeUrl(Page page, string url)
    {
        string urlNormalized = url;
        if (url.StartsWith("~"))
            urlNormalized = url.Replace("~", page.Request.ApplicationPath);

        return urlNormalized;
    }

    /// <summary>
    /// Normaliza uma url trocando o caracter ~ pelo ApplicationPath da requisi��o atual.
    /// </summary>
    /// <param name="url">Url a ser normalizada.</param>
    /// <returns>Url normalizada.</returns>
    public static string NormalizeUrl(string url)
    {
        string urlNormalized = url;
        if (url.StartsWith("~"))
            urlNormalized = url.Replace("~", System.Web.HttpContext.Current.Request.ApplicationPath);

        return urlNormalized;
    }

    /// <summary>
    /// Retorna true caso a url esteja normalizada.
    /// </summary>
    /// <param name="url">Url a ser checada.</param>
    /// <returns>True caso a url esteja normalizada.</returns>
    public static bool IsNormalized(string url)
    {
        return !url.StartsWith("~");
    }

    /// <summary>
    /// Retorna um texto com os caracteres especiais trocados pelos caracteres HTML CODE
    /// </summary>
    /// <param name="Text">Texto que passar� pela codifica��o</param>
    /// <returns>Texto codificado em HTML CODE</returns>
    public static string FormatCharsToHTMLEntities(string text)
    {
        System.Text.StringBuilder resultado = new System.Text.StringBuilder();

        for (int i = 0; i < text.Length; i++)
        {
            char c = text[i];
            resultado.Append(ChangeCharToHtmlEntity(c));
        }

        return resultado.ToString();
    }

    /// <summary>
    /// Retorna o caracter que for passado alterado para HTML CODE
    /// </summary>
    /// <param name="originalChar">Caracter que ser� verificado e trocado pelo HTML CODE se necess�rio</param>
    /// <returns>Caracter codificado em HTML CODE</returns>
    private static string ChangeCharToHtmlEntity(char originalChar)
    {
        string resultado;

        switch (originalChar)
        {
            case '�':
                resultado = "&Aacute;";
                break;
            case '�':
                resultado = "&aacute;";
                break;
            case '�':
                resultado = "&Atilde;";
                break;
            case '�':
                resultado = "&atilde;";
                break;
            case '�':
                resultado = "&Acirc;";
                break;
            case '�':
                resultado = "&acirc;";
                break;
            case '�':
                resultado = "&Agrave;";
                break;
            case '�':
                resultado = "&agrave;";
                break;
            case '�':
                resultado = "&Eacute;";
                break;
            case '�':
                resultado = "&eacute;";
                break;
            case '�':
                resultado = "&Ecirc;";
                break;
            case '�':
                resultado = "&ecirc;";
                break;
            case '�':
                resultado = "&Iacute;";
                break;
            case '�':
                resultado = "&iacute;";
                break;
            case '�':
                resultado = "&Otilde;";
                break;
            case '�':
                resultado = "&otilde;";
                break;
            case '�':
                resultado = "&Oacute;";
                break;
            case '�':
                resultado = "&oacute;";
                break;
            case '�':
                resultado = "&Ocirc;";
                break;
            case '�':
                resultado = "&ocirc;";
                break;
            case '�':
                resultado = "&Ccedil;";
                break;
            case '�':
                resultado = "&ccedil;";
                break;
            case '�':
                resultado = "&Uacute;";
                break;
            case '�':
                resultado = "&uacute;";
                break;
            case '�':
                resultado = "&Uuml;";
                break;
            case '�':
                resultado = "&uuml;";
                break;
            case '�':
                resultado = "&ordf;";
                break;
            case '�':
                resultado = "&ordm;";
                break;
            case '<':
                resultado = "&lt;";
                break;
            case '>':
                resultado = "&gt;";
                break;
            case '&':
                resultado = "&amp;";
                break;
            case '-':
                resultado = "&#45;";
                break;
            default:
                resultado = originalChar.ToString();
                break;
        }

        return resultado;
    }
}