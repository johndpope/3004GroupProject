

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