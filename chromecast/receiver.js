var namespace = "urn:x-cast:com.chipmunk.chromecast";

window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance();

// Handle host disconnecting from chromecast.
window.castReceiverManager.onSenderDisconnected = function(event) {
	if(window.castReceiverManager.getSenders().length == 0 &&
	event.reason == cast.receiver.system.DisconnectReason.REQUESTED_BY_SENDER) {
		window.close();
	}
}

window.castReceiverManager.onSenderConnected = function(senderID, userAgent) {
	console.log("yolo");
}

// 
var messageBus = window.castReceiverManager.getCastMessageBus(namespace);

var corner = 0;
var corners = ["topleft", "topright", "btmleft", "btmright"];

messageBus.onMessage = function(event) {
	var sender = event.senderId;
	var data = event.data;

	if (data.content) { // Is media message
		$("#" + corners[corner]).append(
			"<" + data.content + " src='" + data.src + "'></" + data.content + ">");
		corner = (corner + 1) % 4;
	} else { // Is password setter message
		$("#password").empty();
		$("#password").append("Password: " + data.password);
	}
};


// Begin receiving messages from host phone.
window.castReceiverManager.start();