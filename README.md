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
AutoLISP offers the `(*error*)` [function](https://autode.sk/2ESvhk6) as a error handling. Although this is useful, there's no way to the developer knows that a common error is being thrown without users telling him.

Thinking about that, here it is an example of how to send the error message and other useful data to a remote server using [AutoCAD's Javascript library](http://bit.ly/2UsWBek). First of all, open **errorreporter.lsp** and change your **errorreporter.js** file location when using `(command-s "._WEBLOAD")`. Load that file with VisualLISP and it'll replace your default `(*error*)` function. Then finally execute a code that will throw an error:
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

## Security and digitally signed files
Digitally signed applications in AutoCAD offer a security level for file authenticity. By signing LSP, FAS, DLL, VLX and many more types, user is informed by whom signed that file and if its contents remain unchanged after first signed before `APPLOAD` loads it. To learn more about how certificates help AutoCAD applications, follow this link: https://autode.sk/2SOhdf4 .

To enable this feature in AutoCAD, the following files are required:
- A digital identity issued from a valid Certificate Authority;
- Attach Digital Signatures (AcSignApply.exe) software from AutoDesk;

AcSignApply is already available from AutoCAD installation package and should be accessible from start menu.

The digital identity can be bought from a valid Certificate Authority (CA) or be created by the user through a self-signed CA. In this case and for test purposes, it is used OpenSSL to create the CA and the identity that will sign the files.

At the command line with OpenSSL, execute the following:
Generate a new Certificate Authority in `ca.csr` with its private key on `ca.key`:
```shell
openssl req -new -newkey rsa:2048 -nodes -out ca.csr -keyout ca.key
```

## Next projects
- **Coordinate System Properties**: How to change coordinate systems and make them interact with each other;
- **Angle Operations**: Rotate objects and calculate angles between dependent objects;
- **File Operations**: Wide view across file operations in LISP. RWD, filters and text searching;
- **Reactors**: How to catch callback events from AutoCAD;
- **External Processing of Heavy Data**: Enable AutoCAD to run an external program by transfering huge amounts of data. When result is calculated, finish routine with output data;