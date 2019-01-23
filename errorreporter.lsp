;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    AutoLISP DCL CHEAT SHEET
;; PURPOSE:  A COMPLETE EXAMPLE OF DCL FUNCTIONALITIES AND COMMON ACTIONS WITH ITS
;;           ELEMENTS
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATION: 2019-01-23
;; MANUAL:   https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2016/ENU/AutoCAD-AutoLISP/files/GUID-F4A63A70-EB72-4F7D-A90C-3C5ABD6864A9-htm.html
;; REVISIONS:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This will replace the default error
(defun *error* (msg /  )
  ;; It is important to check other autocad's versions for the same pattern
  (if (not (vl-position msg (list "Function cancelled" "quit / exit abort")))
    (progn
      ;; Save some variables to be sent to error form
      
       
      ;; Call the error report
      (command "._WEBLOAD" "_L" (strcat "C:/Users/Victor Torres/Documents/GitHub/vlisputils/errorreporter.js?r=" (rtos (getvar "CDATE") 2 6)))

    );_progn
    ;; JUST CANCEL
    (princ "\n*Cancel*")
  );_if
  
  (princ)
  
);_defun *error*