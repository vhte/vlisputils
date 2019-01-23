//https://df-prod.autocad360.com/jsapi/v3/docs/Acad_Application_showHTMLDialog@url@options.html
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
Acad.Application.showHTMLDialog("C:/Users/Victor Torres/Documents/GitHub/vlisputils/errorreporter.html?a=" + Math.random(), options);