// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
    handleAvailabilityCheckbox("#mondayCheckbox", "#monday-slider");
    handleAvailabilityCheckbox("#tuesdayCheckbox", "#tuesday-slider");
    handleAvailabilityCheckbox("#wednesdayCheckbox", "#wednesday-slider");
    handleAvailabilityCheckbox("#thursdayCheckbox", "#thursday-slider");
    handleAvailabilityCheckbox("#fridayCheckbox", "#friday-slider");
    handleAvailabilityCheckbox("#saturdayCheckbox", "#saturday-slider");
    handleAvailabilityCheckbox("#sundayCheckbox", "#sunday-slider");
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

function handleAvailabilityCheckbox(checkbox, slider) {
    $(checkbox).click(function() {
        if($(this).is(':checked')) {
            $(slider).slider('disable')
        }
        else {
            $(slider).slider('enable')
        }
    });
}
