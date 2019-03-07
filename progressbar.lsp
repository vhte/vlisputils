;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TITLE:    PROGRESS BAR
;; PURPOSE:  A SIMPLE PROGRESS BAR TO UPDATE USER WHILE CODE IS RUNNING
;; WRITTEN:  VICTOR TORRES - TALK@VICTORTORR.ES || HTTPS://GITHUB.COM/VHTE/VLISPUTILS
;; CREATED:  2019-02-15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CALL THE DCL
(defun progress ( / dialog)
  (setq dialog (load_dialog "C:/Users/Victor Torres/Documents/GitHub/vlisputils/progressbar.dcl"))
  (new_dialog "progress" dialog)
  (start_image "ima")
  (fill_image 0 0 (dimx_tile "ima") (dimy_tile "ima") 254)
  (end_image)
  (action_tile "but" "(progress-set)")
  (setq diaret (start_dialog))
  (unload_dialog dialog)
  (princ)
);_defun progress

;; SET A PERCENTAGE VALUE ON IMAGE TILE
(defun progress-set ( / perc bsize limit actual color)
  (setq perc (atoi (get_tile "per"))
        bsize (/ (dimx_tile "ima") 10);; BLOCK SIZE
        limit (/ (* perc (dimx_tile "ima")) 100 )
        actual 0
        color 5 ;; BLUE
        bg 254)

  ;; LIMITING VALUES
  (if (and (>= perc 0) (<= perc 100))
    (progn
      (start_image "ima")
      (fill_image 0 0 (dimx_tile "ima") (dimy_tile "ima")  bg)
      (while (< (+ actual bsize 2) limit)
        (fill_image actual 0 bsize (dimy_tile "ima")  color)
        (setq actual (+ actual bsize 2))
      );_while
      
      ;; ADD THE REST
      (fill_image actual 0 (- limit actual ) (dimy_tile "ima")  color)
      (end_image)
    );_progn
  );_if
);_defun progress-set