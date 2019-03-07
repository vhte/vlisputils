;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    SYSTEM ACCESS AND ADMINISTRATION
;; PURPOSE:  GET AND SET SYSTEM VARIABLES AND RUN EXTERNAL PROGRAMS INSIDE AUTOCAD
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATED:  2019-01-28
;; MANUAL:   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; C:SYS-REP     A REPORT THAT SHOW MANY VARIABLES FROM CURRENT WINDOWS SYSTEM
;; REGISTRY-KEYS  GET MANY DATA FROM WINDOWS REGISTRY KEYS
;; SCREEN-RESOLUTION GET THE MAIN SCREEN RESOLUTION FROM USER
;;

(defun c:sysrep ( / rep )
  ;; LOAD ACTIVEX SUPPORT
  (vl-load-com)
  
  (setq rep (strcat "***** SYSTEM VARIABLES AND ADMINISTRATION *****\n\n"
                    "\nWindows and user:" (windows-data)
                    "\nScreen resolution: " (screen-resolution)))

  (princ rep)
  (princ)
);_defun c:sysrep

(defun windows-data ( / user windows ret)
  ;; GET CURRENT USER
  (setq user (getenv "USERNAME")
        ;; (getenv "OS")
        windows (vl-registry-read "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\" "ProductName")
        ret (strcat "Current OS: " windows "; Username: " user))

  ret
);_defun windows-data

;; REQUIRES: POWERSHELL ACCESS
(defun screen-resolution ( / ws obj error message file res fn top left
                             width height line window start end dpi)
  
  (setq file "C:\\Users\\Victor Torres\\Documents\\GitHub\\vlisputils\\resolution.txt"
        window (list 400 800))
  ;; IF YOU WANT TO SET DCL WINDOWS POSITION, YOU MUST KNOW USER'S SCREEN RESOLUTION
  ;; DCL POSITION WITH NEW_DIALOG WORKS ONLY ON THE MAIN SCREEN
  ;; GET MAIN SCREEN RESOLUTION
  (setq ws (vlax-create-object "WScript.Shell"))
  ;; TRY CATCH SINCE SOME USERS DO NOT HAVE POWERSHELL ACCESS
  (setq obj (vl-catch-all-apply 'vlax-invoke-method (list ws 'Run (strcat "powershell.exe -nologo -noninteractive -command (Add-Type -AssemblyName System.Windows.Forms);[System.Windows.Forms.Screen]::PrimaryScreen.Bounds | out-file -encoding ASCII '" file "'") 0)))
  (if (vl-catch-all-error-p obj)
    (setq error T
          message (vl-catch-all-error-message obj))
  );_if

  ;; THE SENT OBJECT IS ASYNC, SO THERE'S A @TODO HERE TO WAIT UNTIL FILE IS COMPLETE
  (vlax-release-object ws)

  ;; CHECK IF SOMETHING WAS GENERATED AND NO ERROR FOUND
  (if (and (not error)
           (findfile file))
    (progn
      (setq fn (open file "r"))
      ;; READ FILE UNTIL EVERYTHING IS SET OR END OF FILE REACHED
      (while (and (or (not width) (not height)
                      (not top) (not left))
                  (setq line (read-line fn)))
        (cond
          ((vl-string-search "Top" line)
            (setq top (atoi (substr line (+ 2 (vl-string-position (ascii ":") line)))))
          );_top
          ((vl-string-search "Left" line)
            (setq left (atoi (substr line (+ 2 (vl-string-position (ascii ":") line)))))
          );_left
          ((vl-string-search "Width" line)
            (setq width (atoi (substr line (+ 2 (vl-string-position (ascii ":") line)))))
          );_width
          ((vl-string-search "Height" line)
            (setq height (atoi (substr line (+ 2 (vl-string-position (ascii ":") line)))))
          );_height
          
        );_cond
      );_while

      ;; CLOSE FILE DESCRIPTOR
      (close fn)

      ;; MAKE SURE HEIGHT AND WIDTH EXISTS
      (if (or (not width) (not height))
        (setq res "*ERROR* Couldn't find width and/or height.")
        (progn
          ;; MAKE SURE TOP AND LEFT ARE SET
          (if (not top)
            (setq top 0)
          );_if
          (if (not left)
            (setq left 0)
          );_if
          
          ;; APPLY DPI CORRECTION (SCALE) AND MANY SCREENS SUPPORT
          (setq dpi (vl-registry-read "HKEY_LOCAL_MACHINE\\Control Panel\\Desktop\\WindowMetrics" "AppliedDPI"))
          (cond
            ((= dpi 96)
             (setq dpi 1.00)
            );_100%
            ((= dpi 120)
             (setq dpi 1.25)
            );_125%
            ((= dpi 144)
             (setq dpi 1.5)
            );_150%
            ((= dpi 192)
             (setq dpi 2.0)
            );_200%
            (T
             (setq dpi 1.0)
            );_T
          );_cond

          ;; CALCULATE START POSITION OF MAIN SCREEN (IF MANY)
          (setq start (list (* left dpi) (- (+ (* left dpi) (* width dpi)) (car window)))
                end (list (* top dpi) (- (* dpi height) (cadr window))))
          (setq res (strcat (itoa width) "x" (itoa height) ";\n\t\tFor a (new_dialog) command in a " (itoa (car window)) "x" (itoa (cadr window)) " window, min/max values are: top " (rtos (car start) 2 0) "-" (rtos (cadr start) 2 0) " x left " (rtos (car end) 2 0) "-" (rtos (cadr end) 2 0) ))
        );_progn
      );_if

      ;; MAKE SURE TMP FILE IS DELETE
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
  res
  
);_defun screen-resolution