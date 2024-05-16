// Fun��o que ir� montar as consultas e pagina��o
function configurarConsulta(tabelaId, valorConsulta, valorPesquisa, urlConsulta, metodo) {
    
    $(document).ready(function () {
        // Vari�veis globais para controlar a pagina��o
        var registrosPorPagina = 20; // N�mero de registros por p�gina
        var paginaAtual = 1; // P�gina atual

        // Fun��o para atualizar a p�gina atual e exibir registros
        function atualizarPagina(pagina) {
            paginaAtual = pagina;
            exibirRegistrosPorPagina(pagina);
            atualizarBotoesPaginacao();
        }

        // Fun��o para ir para a primeira p�gina
        function irParaPrimeiraPagina() {
            atualizarPagina(1);
        }

        // Fun��o para ir para a �ltima p�gina
        function irParaUltimaPagina() {
            var numPaginas = Math.ceil($(tabelaId + ' tbody tr').length / registrosPorPagina);
            atualizarPagina(numPaginas);
        }

        // Fun��o para atualizar o estado dos bot�es "Anterior" e "Pr�ximo"
        function atualizarBotoesPaginacao() {
            var numPaginas = Math.ceil($(tabelaId + ' tbody tr').length / registrosPorPagina);

            // Desabilitar o bot�o "Anterior" se estiver na primeira p�gina
            if (paginaAtual === 1) {
                $('#paginaAnterior').addClass('disabled');
            } else {
                $('#paginaAnterior').removeClass('disabled');
            }

            // Desabilitar o bot�o "Pr�ximo" se estiver na �ltima p�gina
            if (paginaAtual === numPaginas) {
                $('#paginaProxima').addClass('disabled');
            } else {
                $('#paginaProxima').removeClass('disabled');
            }
        }

        // Fun��o para exibir registros com base na p�gina atual
        function exibirRegistrosPorPagina(pagina) {
            var startIndex = (pagina - 1) * registrosPorPagina;
            var endIndex = startIndex + registrosPorPagina;

            // Esconda todos os registros
            $(tabelaId + ' tbody tr').hide();

            // Mostre apenas os registros da p�gina atual
            $(tabelaId + ' tbody tr').slice(startIndex, endIndex).show();

            // Remova a classe 'active' de todos os links de p�gina
            $('.pagination li.page-item').removeClass('active');

            // Adicione a classe 'active' ao link da p�gina atual
            $('.pagination li.page-item a.page-link:contains(' + pagina + ')').parent().addClass('active');
        }

        // Manipulador de evento para clicar em um link de p�gina
        $('.pagination').on('click', 'a.page-link', function (e) {
            e.preventDefault();

            var paginaClicada = parseInt($(this).text());

            if (!isNaN(paginaClicada)) {
                atualizarPagina(paginaClicada);
            } else if ($(this).parent().is('#paginaAnterior')) {
                if (paginaAtual > 1) {
                    atualizarPagina(paginaAtual - 1);
                }
            } else if ($(this).parent().is('#paginaProxima')) {
                if (paginaAtual < numPaginas) {
                    atualizarPagina(paginaAtual + 1);
                }
            }
        });

        // Obtenha o valor do campo de entrada
        var consulta = $(valorConsulta).val();
        var pesquisa = $(valorPesquisa).val();

        $.ajax({
            url: urlConsulta,
            type: metodo,
            dataType: 'json',
            data: { consulta: consulta, tipoPesquisa: pesquisa }, // Adicione o valor do campo como par�metro
            success: function (data) {

                // Mostre a div da pagina��o e do contador
                $('#paginacaoRegistrosDiv').show();
                $('#contadorRegistrosDiv').show();
                $('#contadorRegistros').text(data.length);

                // Remove todos os itens de p�gina, exceto os de "Anterior" e "Pr�ximo"
                $('.pagination li').not('#paginaAnterior, #paginaProxima').remove();

                // Calcula o n�mero total de p�ginas com base no n�mero de registros e registros por p�gina
                var numPaginas = Math.ceil(data.length / registrosPorPagina);

                // Adiciona links de p�gina dinamicamente
                for (var i = 1; i <= numPaginas; i++) {
                    var pageLink = $('<a>').addClass('page-link').attr('href', '#').text(i);
                    var li = $('<li>').addClass('page-item').append(pageLink);
                    $('#paginaProxima').before(li);
                }

                // Exibe os registros da p�gina atual
                exibirRegistrosPorPagina(paginaAtual);

                // Configure os bot�es "Anterior" e "Pr�ximo" para chamar as fun��es apropriadas
                $('#paginaAnterior').click(function () {
                    if (!$(this).hasClass('disabled')) {
                        irParaPrimeiraPagina();
                    }
                });

                $('#paginaProxima').click(function () {
                    if (!$(this).hasClass('disabled')) {
                        irParaUltimaPagina();
                    }
                });

                // Inicialize os bot�es de pagina��o no carregamento da p�gina
                atualizarBotoesPaginacao();
            },
            error: function () {
                alert('Erro ao consultar pessoas.');
            }
        });
    });
}