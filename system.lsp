;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    SYSTEM ACCESS AND ADMINISTRATION
;; PURPOSE:  GET AND SET SYSTEM VARIABLES AND RUN EXTERNAL PROGRAMS INSIDE AUTOCAD
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATION: 2019-01-28
;; MANUAL:   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; GET-REPORT     A REPORT THAT SHOW MANY VARIABLES FROM CURRENT WINDOWS SYSTEM
;; REGISTRY-KEYS  GET MANY DATA FROM WINDOWS REGISTRY KEYS
;;


;; REQUIRES: POWERSHELL ACCESS
(defun screen-resolution ( / ws obj error message file res fn)
  ;; LOAD ACTIVEX SUPPORT
  (vl-load-com)
  
  (setq file "C:\\Users\\Victor Torres\\Documents\\GitHub\\vlisputils\\resolution.txt")
  ;; IF YOU WANT TO SET DCL WINDOWS POSITION, YOU MUST KNOW USER'S SCREEN RESOLUTION
  ;; DCL POSITION WITH NEW_DIALOG WORKS ONLY IN THE MAIN SCREEN
  ;; GET MAIN SCREEN RESOLUTION
  (setq ws (vlax-create-object "WScript.Shell"))
  ;; TRY CATCH SINCE SOME USERS DO NOT HAVE POWERSHELL ACCESS
  (setq obj (vl-catch-all-apply 'vlax-invoke-method (list ws 'Run (strcat "powershell.exe -nologo -command (Add-Type -AssemblyName System.Windows.Forms);[System.Windows.Forms.Screen]::PrimaryScreen.Bounds | out-file -encoding ASCII \"" file "\"") 0)))
  (if (vl-catch-all-error-p obj)
    (setq error T
          message (vl-catch-all-error-message obj))
  );_if

  (vlax-release-object ws)

  ;; CHECK IF SOMETHING WAS GENERATED AND NO ERROR FOUND
  (if (and (not error)
           (findfile file))
    (progn
      (setq fn (open file "r")
            res (strcat "" (read-line fn))
            res (strcat res (read-line fn)))
      (close fn)

      ;; DELET TEMP FILE
      (vl-file-delete file)
    );_progn

    ;; MANAGE ERROR
    (progn
      (setq res "*ERROR* ")
      (if message
        (setq res (strcat res message))
        (setq res (strcat res "file not found."))
      );_if
    );_progn
  );_if

  ;; RETURN SCREEN RESOLUTION
  (princ res)
  (princ)
);_defun screen-resolution