# VisualLISP Utils

This repository is a collection of AutoLISP functionalities for developers. The following available implementations are useful to aid development process along AutoCAD and all its interactions with Visual LISP Editor. This project is tested in **AutoCAD 2017** and VisualLISP kern VLLib: IDE v.T* Mar 03 1999, build #692 [2/6/16].

## DCL Cheat Sheet
A complete example of DCL functionalities, its tiles and common actions. To run this program, set first `dcl_id` variable in **dcl_cheat_sheet.lsp** with the correct location of **dcl_cheat_sheet.dcl**.
```lisp
(setq dcl_id (load_dialog "C:/Git/dcl_cheat_sheet.dcl"))
```
Load dcl_cheat_sheet.lsp file using `(load)` in command line or load inside VisualLISP. Call command `DCLCS` in command line or type `(C:DCLCS)` in VisualLISP console.

## VLX Operations and Application Lockdown
Create separate namespace to the application and shows how to interact with drawing namespace. Code security;
Start VisualLISP and select File -> Make Application -> Make Application. Find the **VLX.prv** file  and a VLX.vlx file will be created. It is important to notice `(:separate-namespace . T)` inside the .prv file that locks the whole application, i.e. variables and functions that are not commands will be invisible to the default namespace.

The VLX application can be Loaded by using the command:
```lisp
(load "C:/Git/VLX.vlx")
```

## Error report
AutoLISP offers the `(*error*)` [function](https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2016/ENU/AutoCAD-AutoLISP/files/GUID-CF913180-17CC-43C7-B89F-3BC82FFBEFB9-htm.html) as a error handling. Although this is useful, there's no way to the developer knows that a common error is being thrown without users telling him.

Thinking about that, here it is an example of how to send the error message and other useful data to a remote server using [AutoCAD's Javascript library](https://df-prod.autocad360.com/jsapi/v3/GettingStart/index.html). First of all, open **errorreporter.lsp** and change your **errorreporter.js** file location when using `(command-s "._WEBLOAD")`. Load that file with VisualLISP and it'll replace your default `(*error*)` function. Then finally execute a code that will throw an error:
```lisp
(/ 0 0)
```
This will open AutoCAD's help browser with the error message and a screen capture from user's drawing. It'll also ask for email and description. When user submits the form, it'll use some JavaScript (jQuery) to retrieve data and stay ready to send it through an Ajax request.

The HTML window properties inside AutoCAD should be edited through `options[]` variable inside **errorreporter.js**. Current browser uses Chrome engine, but it seems to be a bit old.

## System Access, Variables and Administration
Programming in AutoLISP could be strict to AutoCAD only sometimes. However, this language can also create some Windows objects and read registries. Having access to command line with `(vlax-*)` functions, it could call any executable file on computer if user has enough rights *(actually this is quite dangerous...*). 
In this section it's demonstrated:
- Read Windows registries and OS variables;
- Get main screen resolution with applied DPI to know how to position DCL windows when using `(new_dialog)`;

To execute code, load **system.lsp** in VisualLISP and run `SYSREP` from AutoCAD console or `(C:SYSREP)` from VisualLISP console.

## Progress bar

AutoLISP routines locks whole AutoCAD while active, working as a single synchronous process. When coding a function that will take a lot of processing time, developers should give to the user some feedback about running time.
A progress bar comes in hand when the developer knows his code will need some time to finish a task, even if it's simple like reading a file. By adding a progress bar and setting steps inside the routine, user can have an idea of how the program is handling the request.
The progress bar in this case can be used by loading `progressbar.lsp` inside VisualLISP. Just call `(progress)` on AutoCAD/VisualLISP command line and a dialog box will be loaded with an interactive way to show the progress bar.

## Next projects
- **Coordinate System Properties**: How to change coordinate systems and make them interact with each other;
- **Angle Operations**: Rotate objects and calculate angles between dependent objects;
- **File Operations**: Wide view across file operations in LISP. RWD, filters and text searching;
- **Reactors**: How to catch callback events from AutoCAD;
- **External Processing of Heavy Data**: Enable AutoCAD to run an external program by transfering huge amounts of data. When result is calculated, finish routine with output data;
- **Security and digitally signed files**: Creates self-signed certificates and sign lsp, vlx, fas and other files to comprove integrity and identity;