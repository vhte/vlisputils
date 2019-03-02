//-----------------------------------------------------------------------------
progress : dialog
{
  label = "Progress bar";
  :edit_box { key = "per"; label="Percent value (0-100)";}
  :button   { key = "but"; label = "Set progress"; width = 15; fixed_width = true; alignment = centered;}
  :image    { key = "ima"; height = 2; width=50;}
  ok_cancel;
}