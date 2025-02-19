$(document).ready(() => {
    let RadioChannel = '0.0';
    let Powered = true;

    window.addEventListener('message', (event) => {
        if (event.data.open === true) {
            if (RadioChannel != '0.0' && Powered) {
                $('#radioChannel').val(RadioChannel);
            } else {
                if (Powered) {
                    $('#radioChannel').val('');
                    $('#radioChannel').attr('placeholder', '0-99.9');
                } else {
                    $('#radioChannel').val('');
                    $('#radioChannel').attr('placeholder', 'OFF');
                }
            }
            $(".full-screen").fadeIn(100);
            $(".wt-container").fadeIn(100);
        } else if (event.data.open === false) {
            $(".full-screen").fadeOut(100);
            $(".wt-container").fadeOut(100);
        }
    });

    document.onkeyup = function (data){
        if (data.which == 27) {
            RadioChannel = parseFloat($('#radioChannel').val());
            if (!RadioChannel) {
                RadioChannel = '0.0';
            }
            closeGui();
        }
    }

    $('#radioForm').submit((e) => {e.preventDefault();});

    $('#power').click(() => {
        if (Powered === false) {
            Powered = true;
            $('#radioChannel').val(RadioChannel);
        } else {
            $.post('http://ab-walkietalkie/close', JSON.stringify({ channel: '0.0' }));
            Powered = false;
            closeGui();
        }
     });
    
    $('#freq-up').click(() => {
        let oldVal = $('#radioChannel').val();
        if(oldVal === '') {
            $('#radioChannel').val('0.0');
        } else if (oldVal === '99.9') {
            $('#radioChannel').val('99.9');
        } else {
            let newVal = (parseFloat(oldVal) + 0.1).toFixed(1);
            $('#radioChannel').val(newVal);
        }
    });
    $('#freq-down').click(() => {
        let oldVal = $('#radioChannel').val();
        if(oldVal === '' || oldVal === '0.0') {
            $('#radioChannel').val('0.0');
        } else {
            let newVal = (parseFloat(oldVal) - 0.1).toFixed(1);
            $('#radioChannel').val(newVal);
        }
    });

    function closeGui() {
        if (RadioChannel < 0.1 || RadioChannel > 99.9) {
            RadioChannel = '0.0';
        }
        $.post('http://ab-walkietalkie/close', JSON.stringify({ channel: RadioChannel }));
    }
});