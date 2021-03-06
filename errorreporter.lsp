;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    AutoLISP DCL CHEAT SHEET
;; PURPOSE:  A COMPLETE EXAMPLE OF DCL FUNCTIONALITIES AND COMMON ACTIONS WITH ITS
;;           ELEMENTS
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATED:  2019-01-23
;; MANUAL:   https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2016/ENU/AutoCAD-AutoLISP/files/GUID-F4A63A70-EB72-4F7D-A90C-3C5ABD6864A9-htm.html
;;           https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2015/ENU/AutoCAD-AutoLISP/files/GUID-620E034A-9151-427F-B6F5-B360D14DA925-htm.html
;; TODO:     ENABLE LOGFILEMODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This will replace the default error
(defun *error* (msg / oldecho date lastprompt)
  ;; It is important to check other autocad's versions for the same pattern
  (if (not (vl-position msg (list "Function cancelled" "quit / exit abort")))
    (progn
      ;; SAVE SOME VARIABLES TO SEND TO ERROR REPORT
      (setq date (rtos (getvar "CDATE") 2 6)
            lastprompt (getvar "LASTPROMPT"))

      ;; DISABLE THE ECHO TO NOT SHOW URL
      (setq oldecho (getvar "CMDECHO"))
      (setvar "CMDECHO" 0)
      
      ;; CALL THE ERROR REPORT
      (command-s "._WEBLOAD" "_L" (strcat "C:/Users/Victor Torres/Documents/GitHub/vlisputils/errorreporter.js?r=" (rtos (getvar "CDATE") 2 6) "&error=" msg "&date=" date "&prompt=" lastprompt))

      ;; ROLLBACK ECHO
      (setvar "CMDECHO" oldecho)

    );_progn
    ;; JUST CANCEL
    (princ "\n*Cancel*")
  );_if

  ;; USING (VL-EXIT-WITH-VALUE NIL) WILL DISABLE BREAK ON ERROR DEBUG
  ;; USE IT TO TEST YOUR ERROR REPORTER (OR DISABLE "BREAK ON ERROR" ON VLISP)
  (vl-exit-with-value nil)
  ;;(princ)
  
);_defun *error*