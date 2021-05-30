App.chat_room = App.cable.subscriptions.create("ChatRoomChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var chatroom = $('#chatrooms-list').find("[data-chatroom-id='" + data['chat_room_id'] + "']");

    if (data['window'] !== undefined) {
      var chatroom_visible = chatroom.is(':visible');

      if (chatroom_visible) {
        var messages_visible = (chatroom).find('.panel-body').is(':visible');

        if (!messages_visible) {
          chatroom.removeClass('panel-default').addClass('panel-success');
        }
        chatroom.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#chatrooms-list').append(data['window']);
        chatroom = $('#chatrooms-list').find("[data-chatroom-id='" + data['chat_room_id'] + "']");
        chatroom.find('.panel-body').toggle();
      }
    }
    else {
      chatroom.find('ul').append(data['message']);
    }

    var messages_list = chatroom.find('.messages-list');

    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.chat_room.speak(values);
  $(this).trigger('reset');
});
