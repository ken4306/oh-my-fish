function omf_remove_package
  for pkg in $argv
    if not omf_util_valid_package $pkg
      if test $pkg = "wa"
        echo (omf::err)"You can't remove wa"(omf::off) 1^&2
      else
        echo (omf::err)"$pkg is not a valid package/theme name"(omf::off) 1^&2
      end
      return $OMF_INVALID_ARG
    end

    if test -d $OMF_PATH/pkg/$pkg
      emit uninstall_$pkg
      rm -rf $OMF_PATH/pkg/$pkg
    else if test -d $OMF_PATH/themes/$pkg
      if test $pkg = default
        echo (omf::err)"You can't remove the default theme"(omf::off) 1^&2
        return $OMF_INVALID_ARG
      end
      if test $pkg = (cat $OMF_CONFIG/theme)
        omf_theme "default"
      end
      rm -rf $OMF_PATH/themes/$pkg
    end
    if test $status -eq 0
      echo (omf::em)"$pkg succesfully removed."(omf::off)
    else
      echo (omf::err)"$pkg could not be found"(omf::off) 1^&2
    end
  end
  refresh
end
