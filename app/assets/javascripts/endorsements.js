$(document).ready(function() {

  $('.endorsements-link').on('click', function(event){
      event.preventDefault();

      var endorsementCount = $(this).siblings('.endorsements_count');

      $.post(this.href, function(response){
        if(response.new_endorsement_count == 1){ 
         endorsementCount.text(response.new_endorsement_count + ' endorsement');
       } else {        
         endorsementCount.text(response.new_endorsement_count + ' endorsements');
       };
    })
  })
})