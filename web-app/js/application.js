
if (typeof jQuery !== 'undefined') {
    (function($) {
        
        $('select').multiselect({
            multiple:false,
            selectedList:1
        });   
    
        
        $("#inicio").datepicker({
            changeYear: true,
            numberOfMonths: 1,
            onSelect: function(objDatepicker){
            }
        });
     
        $("#final").datepicker({
            changeYear: true,
            numberOfMonths: 1,
            onSelect: function(objDatepicker){
            }
        });
            
           
        $('#spinner').ajaxStart(function() {
            $(this).fadeIn();
        }).ajaxStop(function() {
            $(this).fadeOut();
        });
    })(jQuery);
}
