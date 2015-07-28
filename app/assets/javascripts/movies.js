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
      $('.quiz-container').toggle();
      var hours = Math.floor(response.flight.length/3600)
      var mins = Math.floor(response.flight.length%3600/60)
      $('.flight-length-hours').append('<br><br><br><br><br>')
      $('.flight-length-hours').append('Click each box for more info!<br>')
      $('.flight-length-hours').append(hours + ' hours and '+ mins + ' minutes:')
      for (var i=0;i<response.final_movies.length;i++) {
        var imgUrl = '<img src="http://i.imgur.com/0ib88he.png>" height="60" width="60">'
        $('.movies-container').append("<div class='movie-div'></div>");
        $('.movie-div').last().append('<h5>' + response.final_movies[i].title + '</h5>');
        $('.movie-div').last().append(imgUrl + '<br>');
        $('.movie-div').last().append('<p>' + response.final_movies[i].info + '</p>'+'<br>');
        $('.movie-div p').last().hide()
        //showinfo
        $('.movie-div').last().on('click', function() {
          $(this).last().find('p').toggle()
        })
      }
    })
  })
}
