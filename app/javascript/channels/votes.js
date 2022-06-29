$(document).on('turbolinks:load', function(){
  $('.voting').on('ajax:success', function(e){
    $('.notice').empty()
    
    const vote = e.detail[0];

    if (vote.type === 'Question') {
      $('.vote-question .score').html('Rating: ' + vote.score)
    } else if (vote.type === 'Answer') {
      $('.vote-answer .' + vote.id + ' .score').html('Rating: ' + vote.score)
    }
  })
    .on('ajax:error', function(e) {
      const error = e.detail[0];

      $('.notice').html(error.error);
    })
});