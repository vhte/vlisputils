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

At the command line with OpenSSL, execute the following in order with required parameters (most important is when it asks for YOUR NAME, that will be the name displayed when importing certificates):
```shell
openssl req -new -newkey rsa:2048 -nodes -out ca.csr -keyout ca.key
openssl x509 -trustout -signkey ca.key -req -days 3650 -in ca.csr -out ca.pem
openssl x509 -in ca.pem -inform PEM -out ca.cer -outform DER
```
The command lines below will
- Create a new certificate request and a new RSA 2048 bit RSA private key in `ca.key`;
- Create root CA's self-signed X.509 digital certificate;
- Convert Root CA certificate to `ca.cer` format. The CER format is used as public key certificate file, i.e. the file system's need to validate certificates that will be signed it itself. 

Right now the root certificate authority is created. Import `ca.cer` into **"Trusted Root Certification Authorities"** to let the system sees it as a valid CA.
The next step is to create a Digital ID. Execute the following commands in order with required parameters:
```shell
openssl req -new -newkey rsa:2048 -nodes -out mycert.req -keyout mycert.key
openssl x509 -CA ca.pem -CAkey ca.key -days 365 -CAcreateserial -req -in mycert.req -out mycert.pem
openssl pkcs12 -export -clcerts -in mycert.pem -inkey mycert.key -out mycert.p12
```
The command lines bellow will
- Generate an individual key for a new certificate;
- Use root CA to sign the new certificate for 365 days;
- Export certificate with private key to P12 file format.
 
The `mycert.p12` file is the one needed by AutoCAD to sign files. Import it in **"Personal"** folder at your local certificates.
Now, access AcSignApply software from AutoCAD folder. It will show the Digital ID and enable the signature features.

## Next projects
- **Coordinate System Properties**: How to change coordinate systems and make them interact with each other;
- **Angle Operations**: Rotate objects and calculate angles between dependent objects;
- **File Operations**: Wide view across file operations in LISP. RWD, filters and text searching;
- **Reactors**: How to catch callback events from AutoCAD;
- **External Processing of Heavy Data**: Enable AutoCAD to run an external program by transfering huge amounts of data. When result is calculated, finish routine with output data;