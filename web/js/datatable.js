window.onload = function () {
    var i = $('#page').val();

    if (i == '')
    {
        $('#1').css('background-color', '#ccc');
    }
    if (i != '')
    {
        $('#' + i).css('background-color', '#ccc');
    }
}

$(document).ready(function () {
    $(".pg").on("click", function (e) {
        //alert($(this).val());
        $('#page').val($(this).val());
        return true;
    });
    
    $(".pg1").on("click", function (e) {
        //alert($(this).val());
        //alert($(this).attr('id'));
        $('#page').val($(this).attr('id'));
        $('#startpage').val($(this).attr('id'));
        return true;
    });

    $(".prev").on("click", function (e) {
        //alert('prev');
        var i = $('#page').val();
        //alert(i);

        if (i == '')
        {
            $('#page').val('1');
            return true;
        }
        if (i != '')
        {
            var currpage = parseInt(i);
            //alert(currpage);
            if (currpage > 1)
                var prevpage = currpage - 1;
            else
                var prevpage = 1;
            //alert('prevpage: ' + prevpage);
            $('#page').val(prevpage);
            return true;
        }
    });

    $(".next").on("click", function (e) {
        //alert('next');

        var pagecnt = parseInt($("#pagecnt").val());
        //alert(pagecnt);

        var i = $('#page').val();
        //alert(i);

        if (i == '')
        {
            if (pagecnt > 1)
            {
                $('#page').val('2');
                return true;
            }
        }
        if (i != '')
        {
            var currpage = parseInt(i);
            //alert(currpage);
            if (currpage > 0)
            {
                var nextpage = currpage + 1;
                if (nextpage > pagecnt)
                    nextpage = pagecnt;
            }
            else
                var nextpage = 1;
            //alert('nextpage: ' + nextpage);
            $('#page').val(nextpage);
            return true;
        }
    });
});

function Search(btn, stURL)
{
    //alert(btn);
    var searchtext = '';
    searchtext = $('#txtsearch').val();
    //alert(searchtext);

    if (searchtext != '')
    {
        var strcondition = ' and (';

        $('.table1 > thead > tr > td').each(function () {
            //alert($(this));
            //alert($(this).prop('id'));
            var id = $(this).prop('id');
            if (id != "")
            {
                strcondition = strcondition + id + " like '%" + searchtext + "%' or "
            }
        });

        //alert(strcondition);

        var strcondition1 = strcondition.substring(0, strcondition.length - 4);

        strcondition1 = strcondition1 + ')';

        //alert(strcondition1);

        $('#condition').val(strcondition1);

        $('#stSearchURL').val('txtsearch=1&condition=' + strcondition1);

        document.frm1.action = stURL;
        return true;
    }
    else
    {
        $('#condition').val('');
        $('#stSearchURL').val('');

        document.frm1.action = stURL;
        return true;
    }
}

function ReloadPage(btn, stURL)
{
    $('#page').val('1');
    //$('#txtsearch').val('');
    //$('#condition').val('');
    //$('#stSearchURL').val('');

    document.frm1.action = stURL;
    return true;
}