// This is a comment
DCL_CHEAT_SHEET : dialog {
  label = "DCL Cheat Sheet";
  :row {
    :text {
      label = "This is first row";
      alignment = left;
    }
    :boxed_radio_column {
      label = "Boxed Radio Column";
      :radio_button {
        key = "rb1";
        label = "&Radio button one";
        value = "1"; // Default selected
      }
      :radio_button {
        key = "rb2";
        label = "Radio button two";
      }
    }
    :boxed_column {
      label = "Boxed &Column";
      :popup_list {
        key = "selections";
        value = "0"; // position for default
      }
      :text_part {
        label = "Text part. An image comes below";
      }
      :image {
        key = "img";
        height = 1.0;
        width = 2.0;
        fixed_height = true;
        fixed_width = true;
      }
    }
    spacer;
    :slider {
      key = "slider";
      max_value = 100;
      min_value = 0;
      value = 50;
      small_increment = 2;
      big_increment = 5;
    }

    :edit_box {
      label = "Some Label";
      allow_accept = true; // If I press <Enter> it acts like Ok
      width = 10; // Maybe need ok_cancel
      edit_width = 10;
      edit_limit = 10;
      key = "editallow";
      mnemonic = "L";

    }
  }
  
  :row {
    :text {
      label = "Hello world!";
      alignment = centered;
    }
    :edit_box {
      label = "Input Example: ";
      key = "name";
      mnemonic = "E";
      alignment = centered;
      edit_limit = 15;
      edit_width = 15;
      value = "Default value";
      
    }

    :toggle {
      key = "checkbox";
      label = "A checkbox";
      edit_width = 5;
      value = 1;
    }

    :button {
      key = "accept";
      label = "&Ok"; // Shortcut "O"
      //is_default = true;
      fixed_width = true;
      alignment = centered;
    }
    :cancel_button {
      key = "cancel";
      label = "&Cancel";
      fixed_width = true;
      alignment = centered;
      is_cancel = true;
    }
    :button {
      key = "enableerror";
      label = "Enable &Error";
      fixed_width = true;
    }
    :errtile {
      width = 20;
    }

    // ok_cancel;
  }
}