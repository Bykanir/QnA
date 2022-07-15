import consumer from './consumer'

consumer.subscriptions.create({channel: 'AnswersChannel', question_id: gon.question_id}, {
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
