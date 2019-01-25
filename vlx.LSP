;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    AutoLISP NAMESPACE 101
;; PURPOSE:  DEMONSTRATE HOW FUNCTIONS AND VARIABLES CAN BE HIDDEN FROM ACAD USER
;;           INSIDE AN SEPARATE APPLICATION
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATION: 2016-09-10
;; MANUAL:   https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2015/ENU/AutoCAD-AutoLISP/files/GUID-5784FC6F-82DD-4459-879B-6EC3BD5E88D1-htm.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; SET A GLOBAL VARIABLE FOR THE APPLICATION, WHICH WILL LOAD THIS FILE
(setq GLOBALVARIABLE "If you're reading this, it means you're inside the namespace.\n")

;; FUNCTION AS A COMMAND WILL BE ALWAYS VISIBLE TO THE USER
;; THIS ONE LETS THE USER SET A VALUE FOR NAMESPACE'S GLOBALVARIABLE
(defun C:SETEXAMPLE (string / )
  ;; SET THE VARIABLE INSIDE THE NAMESPACE
  (setq GLOBALVARIABLE string)
  (princ "GLOBALVARIABLE was set inside namespace\n")
);_defun

;; GETS THE NAMESPACE'S GLOBALVARIABLE VALUE
(defun C:GETEXAMPLE ( / )
  ;; THIS WILL PRINT THE NAMESPACE VARIABLE, NOT THE ONE USER COULD SET OUTSIDE
  (princ (strcat "Value of GLOBALVARIABLE inside namespace: " GLOBALVARIABLE "\n"))
);_defun

;; JUST A FUNCTION THAT USER WILL NEVER BE ABLE TO CALL FROM AUTOCAD NAMESPACE
;; THIS FUNCTION CAN ONLY BE CALLED INSIDE THE NAMESPACE
(defun internalfunction ( / )
  (princ "This one can only be called inside namespace")
  (princ)
);_defun

;; ENABLES AN INTERNAL NAMESPACE FUNCTION TO BE VISIBLE IN DOCUMENT'S NAMESPACE
(defun enableinternalfunction ( / )
  ;; ENABLING INTERNALFUNCTION TO BE ACCESSIBLE IN AUTOCAD
  (vl-doc-export 'internalfunction)
  (princ "Function \"internalfunction\" is avaiable to current document's namespace\n")
  (princ)
);_defun

;; GET A VARIABLE FROM DOCUMENT'S NAMESPACE. USEFUL IF YOU HAVE A VARIABLE INSIDE
;; THIS NAMESPACE WITH THE SAME NAME (BUT TRY TO AVOID THAT)
(defun getexternalvariable ( variable / )
  (princ (strcat "Current value of " variable ": "))
  (princ (vl-doc-ref variable))
  (princ "\n")
);_defun

;; SETS A VARIABLE TO THE CURRENT DOCUMENT'S NAMESPACE
(defun setexternalvariable ( variable value / )
  ;; SAME THING AS (SETQ VARIABLE VALUE) IN DOCUMENT'S NAMESPACE
  (vl-doc-set variable value)
  (princ (strcat "Variable " variable " was set in document's namespace\n"))
);_defun

;; IF THERE'S NAMESPACES LOADED, LIST ALL THEIR FUNCTIONS
(defun checkfunctions ( / namespaces namespace functions fun )
  (setq namespaces (vl-list-loaded-vlx))

  (if namespaces
    (foreach namespace namespaces
      (princ (strcat "Namespace " namespace " has the following functions: "))

      (setq functions (vl-list-exported-functions namespace))
      (if functions
        (foreach fun functions
          (princ (strcat fun " "))
        );_foreach
      );_if

      (princ "\n")
    );_foreach
  );_if

  (princ)
);_defun

;; UNLOAD A SPECIFIED VLX APPLICATION
(defun unloadvlx ( name / )
  ;; CHECK IF IT EXISTS AND THEN UNLOAD
  (if (vl-vlx-loaded-p name)
    (progn
      (vl-unload-vlx name)
      (princ (strcat "VLX Application " name " was unloaded\n"))
    );_progn
  );_if
);_defun