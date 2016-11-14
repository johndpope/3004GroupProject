var bonjour = require('bonjour')([])
var host = null;
var namespace = "urn:x-cast:com.chipmunk.chromecast";


window.mediaElement = document.getElementById('media'); // likely not needed
window.mediaManager = new cast.receiver.MediaManager(window.mediaElement); // potentially not needed.


window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance();

// Begin receiving messages from host phone.
window.castReceiverManager.start();

// Handle host disconnecting from chromecast.
window.castReceiverManager.onSenderDisconnected = function(event) {
	if(window.castReceiverManager.getSenders().length == 0 &&
	event.reason == cast.receiver.system.DisconnectReason.REQUESTED_BY_SENDER) {
		window.close();
	}
}

window.castReceiverManager.onSenderConnected = function(senderID, userAgent) {

}




// setInterval(function(){
// 	$.getJSON(host, {}, function(data, status){
// 		var type = (data.content === "img" ? "img" : "video");
// 		$(".media").append("<" + type + " src='" + data.src + "'></" + type + ">");
// 	});
// }, 3000);




var messageBus = castReceiverManager.getCastMessageBus(
    namespace,
    cast.receiver.CastMessageBus.MessageType.JSON
);

messageBus.onMessage = function(event) {
	var sender = event.senderId;
	var data = event.data;
	var type = (data.content === "img" ? "img" : "video");
	$(".media").append("<" + type + " src='" + data.src + "'></" + type + ">");
};


