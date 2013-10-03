(function() {
  var DoorDuino;

  $(function() {
    return DoorDuino.init();
  });

  DoorDuino = {
    messageDisplay: "#main-alert",
    init: function() {
      this.initPusher();
      return this.initNotifier(".notify", "click");
    },
    initPusher: function() {
      var channel, pusher;
      pusher = new Pusher("64df34f71aa202a8ec63");
      channel = pusher.subscribe("notification");
      return channel.bind("notify", function(data) {
        return DoorDuino.sendMessage(data.message, data.type);
      });
    },
    initNotifier: function(elem, event) {
      var $elem;
      $elem = $(elem);
      return $elem.on(event, this, function(e) {
        e.preventDefault();
        return $.post("/notify");
      });
    },
    sendMessage: function(message, type) {
      var $display;
      $display = $(DoorDuino.messageDisplay);
      $display.text(message);
      return $display.prop("class", type);
    },
    clearMessages: function() {
      var $display;
      $display = $(DoorDuino.messageDisplay);
      $display.text("");
      return $display.prop("class", "info");
    }
  };

}).call(this);
