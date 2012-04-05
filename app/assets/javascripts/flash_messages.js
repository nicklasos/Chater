var Flash = {
    message: function (message, messageClass, delaySec) {
        if (!message)
            return;

        delaySec = delaySec || 2000;
        messageClass = messageClass || 'normal';

        var close_link = "<a href='javascript:Flash.deleteAll();'><i class='icon-remove'></i></a><br />";
        var elem = $('<div></div>', {
            'class': 'Flash ' + messageClass,
            'style': 'display: none',
            'html': close_link + message
        });

        $('body').append(elem);
        elem.delay(200).fadeIn(500).delay(delaySec).fadeOut(500, function () {
            elem.remove();
        });
    },
    deleteAll: function() {
      $('.Flash').remove();
    }
}
