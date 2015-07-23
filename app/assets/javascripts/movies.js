// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
// renamed from movies.coffee
$(document).ready(function() {
  submitInfo();
});

function submitInfo(){
  $('#form').on('submit', function(e){
    e.preventDefault();
    var url = $(this).attr('action');
    var type = $(this).attr('method');
    $.ajax({
      type: type,
      url: url,
      data: $(this).serialize(),
      dataType: 'JSON'
    }).done(function(response){
      console.log(response)
      var hours = Math.floor(response.flight.length/3600)
      var mins = Math.floor(response.flight.length%3600/60)
      $('.flight-length-hours').append(hours + ' hours and '+ mins + ' minutes:')
      for(i=0;i<response.final_movies.length;i++){
        $('.movies').append(response.final_movies[i].title + '<br>')
      }
    })
  })
}
