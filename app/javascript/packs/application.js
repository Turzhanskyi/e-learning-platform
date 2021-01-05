// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
import "@fortawesome/fontawesome-free/css/all"
require("stylesheets/application.scss")
require("trix")
require("@rails/actiontext")
require("chartkick") // yarn add chartkick chart.js
require("chart.js")
require("jquery") // yarn add jquery
require("jquery-ui-dist/jquery-ui"); // yarn add jquery-ui-dist

require("jquery") // yarn add jquery
require("jquery-ui-dist/jquery-ui"); // yarn add jquery-ui-dist

require("selectize") // yarn add selectize

import "../trix-editor-overrides"
import "youtube"

$(document).on('turbolinks:load', function(){
    $('.lesson-sortable').sortable({
        cursor: "grabbing",
        cursorAt: { left: 10 },
        placeholder: "ui-state-highlight",
        update: function(e, ui){
            let item = ui.item;
            let item_data = item.data();
            let params = {_method: 'put'};
            params[item_data.modelName] = { row_order_position: item.index() }
            $.ajax({
                type: 'POST',
                url: item_data.updateUrl,
                dataType: 'json',
                data: params
            });
        },
        stop: function(e, ui){
            console.log("stop called when finishing sort of cards");
        }
    });
    $("video").bind("contextmenu",function(){
        return false;
    });

    if ($('.selectize')){
        $('.selectize').selectize({
            sortField: 'text'
        });
    }

});
