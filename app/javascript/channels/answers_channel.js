import consumer from './consumer'

consumer.subscriptions.create('AnswersChannel', {
  connected() {
    this.perform('follow')
  }
  ,
  received(data) {
    if (gon.current_user != data.author_id) {
      $('.answers').append(data.template);
    }
  }
})
