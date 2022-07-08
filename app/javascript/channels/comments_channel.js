import consumer from './consumer'

consumer.subscriptions.create('CommentsChannel', {
  connected() {
    this.perform('follow')
  }
  ,
  received(data) {

    const hay = '#answer-' + data.id + ' .comments-answer'
    console.log(hay)

    if (data.type === 'Answer') {
      $(hay).append(data.template);
    } else {
      $('.comments-question').append(data.template);
    }
  }
})
