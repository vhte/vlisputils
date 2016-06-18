(defun C:DCL_CHEAT_SHEET ( / dcl_id)
  (setq dcl_id (load_dialog "C:/Users/Victor Torres/Google Drive/ProMine/vlisp101/dcl_cheat_sheet.dcl"))
  (if (not (new_dialog "DCL_CHEAT_SHEET" dcl_id))
    (princ "\nDCL not found")
    (progn
      (action_tile "accept" "(done_dialog 1)")
      (action_tile "enableerror" "(error)")
      (mode_tile "name" 2) ;; CHECK MODE_TILE SET
      
      (start_list "selections")
      ;(mapcar 'add_list (list "Option1" "Option2" "Option3"))
      (add_list "Option1")
      (add_list "Option2")
      (end_list)

      (setq popuplist (list "Electrical" "Structural" "Plumbing" "Foundation"))
      (start_list "popuplist" 3)
      (mapcar 'add_list popuplist)
      (end_list)

      (start_image "img")
      (fill_image 0 0 (dimx_tile "img") (dimy_tile "img") 5)
      (end_image)

      (setq result (start_dialog))
      (unload_dialog dcl_id)

      (if (= result 1)
        (alert "Ok!")
      );_if
      (princ result)
    );_progn
  );_if
  
  (princ)
);_defun

(defun error ( / )
  (set_tile "error" "This is an error!")
);_defun error