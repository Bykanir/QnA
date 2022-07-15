import consumer from './consumer'

consumer.subscriptions.create({channel: 'QuestionsChannel', question_id: gon.question_id}, {
  connected() {
    this.perform('follow')
  }
  ,
  received(data) {
    $('.questions-list').append(data);
  }
})
