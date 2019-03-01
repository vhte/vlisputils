////////////////////////////////////////////////////////////////////////////////////
// TITLE:    ERROR REPORT
// PURPOSE:  EXTRACT INFORMATION FROM AUTOCAD CURRENT SESSION AND OPEN THE ERROR
//           REPORT FILE WITH SOME PARAMETERS
// WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
// CREATION: 2019-01-23
// MANUAL:   https://df-prod.autocad360.com/jsapi/v3/docs/contents.html
// REVISIONS:
////////////////////////////////////////////////////////////////////////////////////

//https://df-prod.autocad360.com/jsapi/v3/docs/Acad_Application_showHTMLDialog@url@options.html
var image = false;

function success(encodedbmp)
{
	var src = "data:image/bmp;base64," + encodedbmp;
	image = src;
	return 1;
}

function error() {
	alert("error");
}

// Create an object with window properties
var options = new Object();
options["modal"] = true;
options["initSize"] = true;
//options["initPosition"] = true;
options["width"] = 500;
options["height"] = 500;
options["allowResize"] = false;
options["allowMinimize"] = false;
options["maxWidth"]=500;
options["maxHeight"]=500;
//options["x"]=100;
//options["y"]=100;
var error = document.currentScript.src.split("error=")[1];
if(!error)
	error = "undefined";

// Capture preview of current drawing
Acad.Application.activedocument.capturePreview(300,169).then(success,error);

var check = function() {
	if(image)
		Acad.Application.showHTMLDialog("C:/Users/Victor Torres/Documents/GitHub/vlisputils/errorreporter.html?r=" + Math.random() + "&image= " + image + "&error=" + error, options);
	else
		setTimeout(check, 100);
}

check();