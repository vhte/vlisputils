;;; dcl_cheat_sheet.lsp
;;; Author: Victor Torres <talk@victortorr.es>
;;;
;;; A complete example of DCL functionalities and common actions with its elements
;;;
;;; FUNCTION DESCRIPTION
;;; C:DCLCS  Loads a .dcl file and set many actions for interaction
;;; SET-TEXT Set a text on a dcl tile as action
;;;
(defun C:DCLCS( / dcl_id llist)
  (setq dcl_id (load_dialog "C:/Users/Victor Torres/Documents/GitHub/vlisputils/dcl_cheat_sheet.dcl"))
  (if (not (new_dialog "DCL_CHEAT_SHEET" dcl_id))
    (princ "\nDCL not found")
    (progn
      (action_tile "accept" "(done_dialog 1)")
      (action_tile "settext" "(set-text)")

      ;; Help also enables F1 key to be used
      (action_tile "help" "(help \"https://github.com/vhte/vlisputils\")")
      (mode_tile "name" 2) ;; Set focus on "name"
      
      (start_list "selections")
      ;(mapcar 'add_list (list "Option1" "Option2" "Option3")) ;; also a good option
      (add_list "Option1")
      (add_list "Option2")
      (end_list)

      (setq llist (list "first line" "second line" "third line"))

      (start_list "listbox" 3) ;; 3 deletes old list and create new one
      (mapcar 'add_list llist)
      (end_list)
      
      (start_list "popuplist" 2) ;; 2 appends a new list entry
      (mapcar 'add_list llist)
      (end_list)

      ;; Fill the whole image with a single color
      (start_image "img")
      (fill_image 0 0 (dimx_tile "img") (dimy_tile "img") 5)
      (end_image)

      ;; Result from dialog (accept, cancel or whatever comes from (done_dialog))
      (setq result (start_dialog))
      (unload_dialog dcl_id)

      ;; Accept = 1, Cancel = 0
      (if (= result 1)
        (alert "Ok!")
      );_if
      (princ result)
    );_progn
  );_if
  
  (princ)
);_defun C:DCLSC

(defun set-text ( / )
  (set_tile "error" "This is a text on an error tile!")
);_defun error