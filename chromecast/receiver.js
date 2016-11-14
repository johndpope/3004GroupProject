var host = null;
var namespace = "urn:x-cast:com.chipmunk.chromecast";


window.mediaElement = document.getElementById('media'); // likely not needed
window.mediaManager = new cast.receiver.MediaManager(window.mediaElement); // potentially not needed.


window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance();

// Handle host disconnecting from chromecast.
window.castReceiverManager.onSenderDisconnected = function(event) {
	if(window.castReceiverManager.getSenders().length == 0 &&
	event.reason == cast.receiver.system.DisconnectReason.REQUESTED_BY_SENDER) {
		window.close();
	}
}

window.castReceiverManager.onSenderConnected = function(senderID, userAgent) {

}

// 
var messageBus = window.castReceiverManager.getCastMessageBus(namespace);

messageBus.onMessage = function(event) {
	var sender = event.senderId;
	var data = event.data;
	$(".media").append("<" + data.content + " src='" + data.src + "'></" + data.content + ">");
};


// Begin receiving messages from host phone.
window.castReceiverManager.start();