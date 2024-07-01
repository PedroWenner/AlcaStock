<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rodape.ascx.cs" Inherits="MasterPages_rodape" %>

<script>
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(function () { BindControlEvents(); });

    function BindControlEvents() {
        $("select").each(function () {
            var currentId = $(this).attr('multiple');
            if ($(this).attr('id') != undefined) {
                if (typeof currentId === 'undefined' && $(this).attr('id').indexOf('_list') == -1 && $(this).attr('id').indexOf('_lst') == -1 && $(this).attr('id').indexOf('_chklist') == -1) {
                    $(this).attr('data-plugin-selectTwo', 'data-plugin-selectTwo');
                    $(this).addClass("form-control populate form-control-sm mb-md");
                }
            }
        });

        (function ($) {

            'use strict';

            if ($.isFunction($.fn['select2'])) {

                $(function () {
                    $('[data-plugin-selectTwo]').each(function () {
                        var $this = $(this),
                            opts = {
                                language: {
                                    noResults: function () {
                                        return "Não há registro(s)";
                                    }
                                }
                            };

                        var pluginOptions = $this.data('plugin-options');
                        if (pluginOptions)
                            opts = pluginOptions;

                        $this.themePluginSelect2(opts);
                    });
                });

            }

        }).apply(this, [jQuery]);

        (function ($) {

            'use strict';

            if ($.isFunction($.fn['mask'])) {

                $(function () {
                    $('[data-plugin-masked-input]').each(function () {
                        var $this = $(this),
                            opts = {};

                        var pluginOptions = $this.data('plugin-options');
                        if (pluginOptions)
                            opts = pluginOptions;

                        $this.themePluginMaskedInput(opts);
                    });
                });

            }

        }).apply(this, [jQuery]);

        /*$("input[type='text']").addClass("form-control input-sm mb-md");*/
        $("input[type='password']").addClass("form-control form-control-sm");
        $("input[type='number']").addClass("form-control form-control-sm");
        /*$("input[type='button']").addClass("mb-xs mt-xs mr-xs btn btn-primary btn-sm");*/
        $("input[type='file']").addClass("form-control form-control-sm");
        /*$("input[type='submit']").addClass("mb-xs mt-xs mr-xs btn btn-primary btn-sm");*/
        $("textarea").addClass("form-control form-control-sm");

        //Máscaras
        $('.txtCpf').mask('999.999.999-99');
        $('.txtCnpj').mask('99.999.999/9999-99');
        $('.txtFone').mask('9999-9999');
        $('.txtFoneCode').mask('(99) 9999-9999');
        $('.txtFone9').mask('9 9999-9999');
        $('.txtFoneCode9').mask('(99) 9 9999-9999');
        $('.txtCep').mask('99999-999');
        $('.txtDate').mask('99/99/9999');
        $('.txtAno').mask('9999');
        $('.txtMoney').mask('000.000.000.000.000,00', { reverse: true });
        $('.txtMoney2').mask("#.##0,00", { reverse: true });

        $("input").each(function () {
            var currentId = $(this).attr('id');
            if (typeof currentId !== 'undefined' && currentId.indexOf("Data") > 0 && currentId.indexOf("hdd") == 0) {
                $("input[type='text']").attr('style', 'width: 150px !important;');
            }
            else if (typeof currentId !== 'undefined' && currentId.indexOf("hdd") == 0) {
                $("input[type='text']").attr('style', 'width: 98% !important');
            }
        });

        $(".btnProc").each(function () {
            //if ($(this).hasClass("btnProc")) {
            $(this).addClass("mb-xs mt-xs mr-xs btn btn-default btn-sm");
            //}
        });

        $("li > a").each(function (index, value) {
            var link = $(this).attr("href");

            if (unescape(location.href).indexOf(link) >= 0) {
                $(this).parents('.nav-parent').addClass('nav-expanded');
                $(this).addClass('text-bold');
                $(this).attr('style', 'color: yellow !important;');
            }
        });

        $('.date').datepicker({
            dateFormat: 'dd/mm/yy',
            mask: '99/99/9999',
            changeMonth: true,
            changeYear: true,
            yearRange: "1900:2100",
            dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'],
            dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D'],
            dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
            monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
            monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
            onClose: function () {
                try {
                    $(this).valid();
                }
                catch (e) {
                }
            }
        });

        $(".iconeDate").click(function () {
            $(".date").datepicker("show");
        });

        $(".money").mask('000.000,00', { reverse: true });
        $(".perc").mask('000,00', { reverse: true });
    }

    $(document).ready(function () {
        BindControlEvents();
    });
</script>

<script src="<%=ResolveClientUrl("~/Library/lib/jquery/dist/jquery.min.js") %>" type="text/javascript"></script>
<script src="<%=ResolveClientUrl("~/Library/lib/bootstrap/dist/js/bootstrap.bundle.min.js") %>" type="text/javascript"></script>
<script src="<%=ResolveClientUrl("~/Library/lib/bootstrap/dist/js/bootstrap.min.js") %>" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous" type="text/javascript"></script>
<script src="<%=ResolveClientUrl("~/Library/js/sb-admin-2.min.js") %>" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js" type="text/javascript"></script>
<script src="<%=ResolveClientUrl("~/Library/js/site.js") %>" type="text/javascript"></script>

<!-- Vendor -->
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/nanoscroller/nanoscroller.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/bootstrap-datepicker/js/locales/bootstrap-datepicker.pt-BR.js") %>" charset="utf-8"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/magnific-popup/magnific-popup.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-placeholder/jquery.placeholder.js") %>"></script>

<!-- Specific Page Vendor -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js" type="text/javascript"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-ui-touch-punch/jquery.ui.touch-punch.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-appear/jquery.appear.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-easypiechart/jquery.easypiechart.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/flot/jquery.flot.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/flot-tooltip/jquery.flot.tooltip.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/flot/jquery.flot.pie.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/flot/jquery.flot.categories.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/flot/jquery.flot.resize.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-sparkline/jquery.sparkline.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/raphael/raphael.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/morris/morris.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/gauge/gauge.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/snap-svg/snap.svg.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/liquid-meter/liquid.meter.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/jquery.vmap.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/data/jquery.vmap.sampledata.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/jquery.vmap.world.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.africa.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.asia.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.australia.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.europe.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.north-america.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jqvmap/maps/continents/jquery.vmap.south-america.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/select2/select2.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-maskedinput/jquery.maskedinput.js") %>"></script>
<script src="<%=ResolveClientUrl("~/assets/vendor/jquery-maskedinput/jquery.mask.js") %>"></script>
<script src="<%=ResolveClientUrl("~/Library/JQuery/jstree/jstree.min.js") %>"></script>

<!-- Theme Base, Components and Settings -->
<script src="<%=ResolveClientUrl("~/assets/javascripts/theme.js") %>"></script>

<!-- Theme Custom -->
<script src="<%=ResolveClientUrl("~/assets/javascripts/theme.custom.js") %>"></script>

<!-- Theme Initialization Files -->
<script src="<%=ResolveClientUrl("~/assets/javascripts/theme.init.js") %>"></script>

<style>
    /*Inicio estilo calendarextender*/
    .ajax__calendar_container {
        padding: 4px;
        cursor: default;
        width: 219px;
        font-size: 11px;
        text-align: center;
        font-family: tahoma, verdana, helvetica;
        height: 245px; /*220px;*/
        width: 225px;
    }

    .ajax__calendar_body {
        width: 200px;
        height: 185px; /*165px;*/
        position: relative;
        overflow: hidden;
        margin: auto;
    }

    .ajax__calendar_days, .ajax__calendar_months, .ajax__calendar_years {
        top: 10px;
        left: -6px;
        height: 150px;
        width: 200px;
        position: absolute;
        text-align: center;
        margin: auto;
    }

    .ajax__calendar_days > table {
        width: 100%;
        margin-left: 10px !important;
    }
    /*Fim estilo calendarextender*/

    .mb-md {
        margin-bottom: 0px !important
    }
</style>
