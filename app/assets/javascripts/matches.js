// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
    $(".availability-slider").slider({
        min: 0,
        max: 720,
        step: 30,
        value: [120, 600],
        tooltip: 'always',
        tooltip_position: 'bottom',
        tooltip_split: true,
        formatter: minutesToTime
    });

    handleDayOfWeek();
    handleAvailabilityCheckbox("#monday-checkbox", "#monday-slider");
    handleAvailabilityCheckbox("#tuesday-checkbox", "#tuesday-slider");
    handleAvailabilityCheckbox("#wednesday-checkbox", "#wednesday-slider");
    handleAvailabilityCheckbox("#thursday-checkbox", "#thursday-slider");
    handleAvailabilityCheckbox("#friday-checkbox", "#friday-slider");
    handleAvailabilityCheckbox("#saturday-checkbox", "#saturday-slider");
    handleAvailabilityCheckbox("#sunday-checkbox", "#sunday-slider");
    handleMatchButton();
});

function minutesToTime(minutes) {
    var hours = Math.floor(minutes / 60) + 8;
    var leftoverMinutes = minutes % 60;

    var output;
    if (hours < 12) {
        output = hours.toString() + ":" + ('0' + leftoverMinutes).substr(-2) + " AM";
    }
    else if (hours == 12) {
        output = hours.toString() + ":" + ('0' + leftoverMinutes).substr(-2) + " PM";
    }
    else {
        output = (hours - 12).toString() + ":" + ('0' + leftoverMinutes).substr(-2) + " PM";
    }
    return output;
}

function handleDayOfWeek() {
    var checkboxes = ["#monday-checkbox", "#tuesday-checkbox", "#wednesday-checkbox",
        "#thursday-checkbox", "#friday-checkbox", "#saturday-checkbox", "#sunday-checkbox"];
    var sliders = ["#monday-slider", "#tuesday-slider", "#wednesday-slider",
        "#thursday-slider", "#friday-slider", "#saturday-slider", "#sunday-slider"];
    var dayOfWeek = $('#day-of-week').attr('data');

    for (i = 0; i < dayOfWeek; i++) {
        $(checkboxes[i]).prop("checked", true).prop("disabled", true);
        $(sliders[i]).slider('disable');
    }
}

function handleAvailabilityCheckbox(checkbox, slider) {
    $(checkbox).click(function() {
        if($(this).is(':checked')) {
            $(slider).slider('disable');
        }
        else {
            $(slider).slider('enable');
        }
    });
}

function handleMatchButton() {
    $("#match-button").click(function() {
        var mondayAvailable = false;
        var tuesdayAvailable = false;
        var wednesdayAvailable = false;
        var thursdayAvailable = false;
        var fridayAvailable = false;
        var saturdayAvailable = false;
        var sundayAvailable = false;

        var mondayTimes = [];
        var tuesdayTimes = [];
        var wednesdayTimes = [];
        var thursdayTimes = [];
        var fridayTimes = [];
        var saturdayTimes = [];
        var sundayTimes = [];

        if(!$("#monday-checkbox").is(':checked')) {
            mondayAvailable = true;
            mondayTimes = $("#monday-slider").slider('getValue');
        }
        if(!$("#tuesday-checkbox").is(':checked')) {
            tuesdayAvailable = true;
            tuesdayTimes = $("#tuesday-slider").slider('getValue');
        }
        if(!$("#wednesday-checkbox").is(':checked')) {
            wednesdayAvailable = true;
            wednesdayTimes = $("#wednesday-slider").slider('getValue');
        }
        if(!$("#thursday-checkbox").is(':checked')) {
            thursdayAvailable = true;
            thursdayTimes = $("#thursday-slider").slider('getValue');
        }
        if(!$("#friday-checkbox").is(':checked')) {
            fridayAvailable = true;
            fridayTimes = $("#friday-slider").slider('getValue');
        }
        if(!$("#saturday-checkbox").is(':checked')) {
            saturdayAvailable = true;
            saturdayTimes = $("#saturday-slider").slider('getValue');
        }
        if(!$("#sunday-checkbox").is(':checked')) {
            sundayAvailable = true;
            sundayTimes = $("#sunday-slider").slider('getValue');
        }

        var cuisines = [];
        $('#cuisine-select :selected').each(function(i, selected){
            cuisines[i] = $(selected).val();
        });

        $.ajax({
            type: 'POST',
            url: '/match_request',
            data: {
                mondayAvailable: mondayAvailable,
                tuesdayAvailable: tuesdayAvailable,
                wednesdayAvailable: wednesdayAvailable,
                thursdayAvailable: thursdayAvailable,
                fridayAvailable: fridayAvailable,
                saturdayAvailable: saturdayAvailable,
                sundayAvailable: sundayAvailable,
                mondayTimes: mondayTimes,
                tuesdayTimes: tuesdayTimes,
                wednesdayTimes: wednesdayTimes,
                thursdayTimes: thursdayTimes,
                fridayTimes: fridayTimes,
                saturdayTimes: saturdayTimes,
                sundayTimes:sundayTimes,
                cuisines: cuisines
            },
            success: function(data) {
                alert('Your match request has been submitted');
                location.reload();
            },
            error: function(data) {
                alert('An error occurred while trying to request a match.');
            }
        });
    });
}