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

var messageBus = window.castReceiverManager.getCastMessageBus(namespace);

var cell = 0;
var num_cells = 4;
var cells = [];

messageBus.onMessage = function(event) {
	var sender = event.senderId;
	var data = JSON.parse(event.data);

	if (data.content) { // Is media message
		$("#" + cells[cell]).css("background-image", "url("+data.src+")");
		console.log("Adding image with url (" + data.src + ") into cell " + cells[cell]);
		cell = (cell + 1) % num_cells;
	} else if (data.settings) {
		applySettings(data.settings);
	}
};

function applySettings(settings) {
	function gen_id(r, c) {
		return r.toString() + "-" + c.toString();
	}

	function gen_div(r, c) { // css is wrong when num_cells=2
		var id = gen_id(r, c);
		var css = "";
		css += "left:" + (c-1)*(100/Math.ceil(num_cells/2)) + "%;";
		css += "width:" + 100/Math.ceil(num_cells/2) + "%;";
		//css += "right:" + c*(100/Math.ceil(num_cells/2)) + "%;";
		css += "top:" + ((r-1)*50).toString() + "%;";
		css += "height:" + (num_cells > 1 ? 50 : 100) + "%;";
		//css += "bottom:" + ((r*(-1)+2)*50).toString() + "%;";
		console.log("css: " + css);

		return "<div class='cell' id='" + id + "' style='" + css + "'></div>";
	}

	$("#password").empty();
	$("#password").append("Password: " + settings.password);

	num_cells = settings.numcells;
	cell = 0;
	cells = [];

	for (var i = 1; i <= 2 && i < num_cells; ++i) {
		for (var j = 0; j < Math.ceil(num_cells/2); ++j) {
			$("#media").append(gen_div(i, j+1));
			cells.push(gen_id(i, j+1));
		}
	}
}




// Begin receiving messages from host phone.
window.castReceiverManager.start();