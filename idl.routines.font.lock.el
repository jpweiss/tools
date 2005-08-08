;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; IDL Routines - added to font-lock
;
; Routine-names will be set to the face
; 'font-lock-reference-face'
;
;
; 11/28/95 j.p.w
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "idl" 
			  '(progn
				(setq idl-routines-keywords
					 (cons
					  (concat
					   "\\<\\("
					   "a_correlate\\|"
					   "abs\\|"
					   "acos\\|"
					   "alog\\|"
					   "alog10\\|"
					   "annotate\\|"
					   "arrow\\|"
					   "asin\\|"
					   "assoc\\|"
					   "atan\\|"
					   "axis\\|"
					   "bar_plot\\|"
					   "beseli\\|"
					   "beselj\\|"
					   "besely\\|"
					   "beta\\|"
					   "bilinear\\|"
					   "bin_date\\|"
					   "bindgen\\|"
					   "binomial\\|"
					   "blk_con\\|"
					   "box_cursor\\|"
					   "breakpoint\\|"
					   "broyden\\|"
					   "bytarr\\|"
					   "byte\\|"
					   "byteorder\\|"
					   "bytscl\\|"
					   "c_correlate\\|"
					   "caldat\\|"
					   "calendar\\|"
					   "call_external\\|"
					   "call_function\\|"
					   "call_procedure\\|"
					   "catch\\|"
					   "cd\\|"
					   "cdf_attcreate\\|"
					   "cdf_attget\\|"
					   "cdf_attinq\\|"
					   "cdf_attnum\\|"
					   "cdf_attput\\|"
					   "cdf_attrename\\|"
					   "cdf_close\\|"
					   "cdf_control\\|"
					   "cdf_create\\|"
					   "cdf_delete\\|"
					   "cdf_doc\\|"
					   "cdf_epoch\\|"
					   "cdf_error\\|"
					   "cdf_exists\\|"
					   "cdf_inquire\\|"
					   "cdf_open\\|"
					   "cdf_varcreate\\|"
					   "cdf_varget\\|"
					   "cdf_varget1\\|"
					   "cdf_varinq\\|"
					   "cdf_varnum\\|"
					   "cdf_varput\\|"
					   "cdf_varrename\\|"
					   "ceil\\|"
					   "chebyshev\\|"
					   "check_math\\|"
					   "chisqr_cvf\\|"
					   "chisqr_pdf\\|"
					   "choldc\\|"
					   "cholsol\\|"
					   "cindgen\\|"
					   "cir_3pnt\\|"
					   "close\\|"
					   "color_convert\\|"
					   "color_quan\\|"
					   "comfit\\|"
					   "complex\\|"
					   "complexarr\\|"
					   "complexround\\|"
					   "cond\\|"
					   "congrid\\|"
					   "conj\\|"
					   "contour\\|"
					   "convert_coord\\|"
					   "convol\\|"
					   "coord2to3\\|"
					   "correlate\\|"
					   "cos\\|"
					   "cosh\\|"
					   "cramer\\|"
					   "create_struct\\|"
					   "create_view\\|"
					   "crossp\\|"
					   "ct_luminance\\|"
					   "cti_test\\|"
					   "cursor\\|"
					   "curvefit\\|"
					   "cv_coord\\|"
					   "cw_animate\\|"
					   "cw_animate_load\\|"
					   "cw_animate_run\\|"
					   "cw_animate_getp\\|"
					   "cw_arcball\\|"
					   "cw_bgroup\\|"
					   "cw_clr_index\\|"
					   "cw_colorsel\\|"
					   "cw_defroi\\|"
					   "cw_dice\\|"
					   "cw_field\\|"
					   "cw_fslider\\|"
					   "cw_orient\\|"
					   "cw_pdmenu\\|"
					   "cw_rgbslider\\|"
					   "cw_tmpl\\|"
					   "cw_zoom\\|"
					   "dblarr\\|"
					   "dcindgen\\|"
					   "dcomplex\\|"
					   "dcomplexarr\\|"
					   "define_key\\|"
					   "defroi\\|"
					   "defsysv\\|"
					   "delvar\\|"
					   "demo_mode\\|"
					   "deriv\\|"
					   "derivsig\\|"
					   "determ\\|"
					   "device\\|"
					   "dfpmin\\|"
					   "digital_filter\\|"
					   "dilate\\|"
					   "dindgen\\|"
					   "disp_txt\\|"
					   "dissolve\\|"
					   "dist\\|"
					   "do_apple_script\\|"
					   "doc_library\\|"
					   "double\\|"
					   "efont\\|"
					   "eigenvec\\|"
					   "elmhes\\|"
					   "empty\\|"
					   "eof\\|"
					   "erase\\|"
					   "erode\\|"
					   "errorf\\|"
					   "errplot\\|"
					   "execute\\|"
					   "exit\\|"
					   "exp\\|"
					   "expand\\|"
					   "expand_path\\|"
					   "expint\\|"
					   "extrac\\|"
					   "extract_slice\\|"
					   "f_cvf\\|"
					   "f_pdf\\|"
					   "factorial\\|"
					   "fft\\|"
					   "filepath\\|"
					   "findfile\\|"
					   "findgen\\|"
					   "finite\\|"
					   "fix\\|"
					   "flick\\|"
					   "float\\|"
					   "floor\\|"
					   "flow3\\|"
					   "fltarr\\|"
					   "flush\\|"
					   "free_lun\\|"
					   "fstat\\|"
					   "fulstr\\|"
					   "funct\\|"
					   "fv_test\\|"
					   "fx_root\\|"
					   "fz_roots\\|"
					   "gamma\\|"
					   "gamma_ct\\|"
					   "gauss_cvf\\|"
					   "gauss_pdf\\|"
					   "gauss2dfit\\|"
					   "gaussfit\\|"
					   "gaussint\\|"
					   "get_kbrd\\|"
					   "get_lun\\|"
					   "getenv\\|"
					   "gethelp\\|"
					   "grid3\\|"
					   "gs_iter\\|"
					   "h_eq_ct\\|"
					   "h_eq_int\\|"
					   "handle_create\\|"
					   "handle_free\\|"
					   "handle_info\\|"
					   "handle_move\\|"
					   "handle_value\\|"
					   "hanning\\|"
					   "hdf_close\\|"
					   "hdf_deldd\\|"
					   "hdf_df24_addimage\\|"
					   "hdf_df24_getimage\\|"
					   "hdf_df24_getinfo\\|"
					   "hdf_df24_lastref\\|"
					   "hdf_df24_nimages\\|"
					   "hdf_df24_readref\\|"
					   "hdf_df24_restart\\|"
					   "hdf_dfan_addfds\\|"
					   "hdf_dfan_addfid\\|"
					   "hdf_dfan_getdesc\\|"
					   "hdf_dfan_getfds\\|"
					   "hdf_dfan_getfid\\|"
					   "hdf_dfan_getlabel\\|"
					   "hdf_dfan_lablist\\|"
					   "hdf_dfan_lastref\\|"
					   "hdf_dfan_putdesc\\|"
					   "hdf_dfan_putlabel\\|"
					   "hdf_dfp_addpal\\|"
					   "hdf_dfp_getpal\\|"
					   "hdf_dfp_lastref\\|"
					   "hdf_dfp_npals\\|"
					   "hdf_dfp_putpal\\|"
					   "hdf_dfp_readref\\|"
					   "hdf_dfp_restart\\|"
					   "hdf_dfp_writeref\\|"
					   "hdf_dfr8_addimage\\|"
					   "hdf_dfr8_getimage\\|"
					   "hdf_dfr8_getinfo\\|"
					   "hdf_dfr8_lastref\\|"
					   "hdf_dfr8_nimages\\|"
					   "hdf_dfr8_putimage\\|"
					   "hdf_dfr8_readref\\|"
					   "hdf_dfr8_restart\\|"
					   "hdf_dfr8_setpalette\\|"
					   "hdf_dfsd_adddata\\|"
					   "hdf_dfsd_dimget\\|"
					   "hdf_dfsd_dimset\\|"
					   "hdf_dfsd_endslice\\|"
					   "hdf_dfsd_getdata\\|"
					   "hdf_dfsd_getinfo\\|"
					   "hdf_dfsd_getslice\\|"
					   "hdf_dfsd_putslice\\|"
					   "hdf_dfsd_readref\\|"
					   "hdf_dfsd_setinfo\\|"
					   "hdf_dfsd_startslice\\|"
					   "hdf_dupdd\\|"
					   "hdf_exists\\|"
					   "hdf_ishdf\\|"
					   "hdf_newref\\|"
					   "hdf_number\\|"
					   "hdf_open\\|"
					   "hdf_sd_adddata\\|"
					   "hdf_sd_attrfind\\|"
					   "hdf_sd_attrinfo\\|"
					   "hdf_sd_attrset\\|"
					   "hdf_sd_create\\|"
					   "hdf_sd_dimget\\|"
					   "hdf_sd_dimgetid\\|"
					   "hdf_sd_dimset\\|"
					   "hdf_sd_end\\|"
					   "hdf_sd_endaccess\\|"
					   "hdf_sd_fileinfo\\|"
					   "hdf_sd_getdata\\|"
					   "hdf_sd_getinfo\\|"
					   "hdf_sd_iscoordvar\\|"
					   "hdf_sd_nametoindex\\|"
					   "hdf_sd_reftoindex\\|"
					   "hdf_sd_select\\|"
					   "hdf_sd_setextfile\\|"
					   "hdf_sd_setinfo\\|"
					   "hdf_sd_start\\|"
					   "hdf_vd_attach\\|"
					   "hdf_vd_define\\|"
					   "hdf_vd_detach\\|"
					   "hdf_vd_fexist\\|"
					   "hdf_vd_find\\|"
					   "hdf_vd_get\\|"
					   "hdf_vd_getid\\|"
					   "hdf_vd_getinfo\\|"
					   "hdf_vd_getnext\\|"
					   "hdf_vd_insert\\|"
					   "hdf_vd_isvd\\|"
					   "hdf_vd_isvg\\|"
					   "hdf_vd_lone\\|"
					   "hdf_vd_read\\|"
					   "hdf_vd_seek\\|"
					   "hdf_vd_setinfo\\|"
					   "hdf_vd_write\\|"
					   "hdf_vg_addtr\\|"
					   "hdf_vg_attach\\|"
					   "hdf_vg_detach\\|"
					   "hdf_vg_getid\\|"
					   "hdf_vg_getinfo\\|"
					   "hdf_vg_getnext\\|"
					   "hdf_vg_gettr\\|"
					   "hdf_vg_gettrs\\|"
					   "hdf_vg_inqtr\\|"
					   "hdf_vg_insert\\|"
					   "hdf_vg_isvd\\|"
					   "hdf_vg_isvg\\|"
					   "hdf_vg_lone\\|"
					   "hdf_vg_number\\|"
					   "hdf_vg_setinfo\\|"
					   "help\\|"
					   "hilbert\\|"
					   "hist_2d\\|"
					   "hist_equal\\|"
					   "histogram\\|"
					   "hls\\|"
					   "hqr\\|"
					   "hsv\\|"
					   "ibeta\\|"
					   "igamma\\|"
					   "image_cont\\|"
					   "imaginary\\|"
					   "indgen\\|"
					   "int_2d\\|"
					   "int_3d\\|"
					   "int_tabulated\\|"
					   "intarr\\|"
					   "interpol\\|"
					   "interpolate\\|"
					   "invert\\|"
					   "ioctl\\|"
					   "ishft\\|"
					   "journal\\|"
					   "julday\\|"
					   "keyword_set\\|"
					   "krig2d\\|"
					   "kw_test\\|"
					   "label_date\\|"
					   "label_region\\|"
					   "ladfit\\|"
					   "leefilt\\|"
					   "linbcg\\|"
					   "lindgen\\|"
					   "linfit\\|"
					   "linkimage\\|"
					   "ljlct\\|"
					   "ll_arc_distance\\|"
					   "lngamma\\|"
					   "lnp_test\\|"
					   "loadct\\|"
					   "lonarr\\|"
					   "long\\|"
					   "lu_complex\\|"
					   "ludc\\|"
					   "lumprove\\|"
					   "lusol\\|"
					   "m_correlate\\|"
					   "machar\\|"
					   "make_array\\|"
					   "map_continents\\|"
					   "map_grid\\|"
					   "map_image\\|"
					   "map_patch\\|"
					   "map_set\\|"
					   "max\\|"
					   "md_test\\|"
					   "median\\|"
					   "mesh_obj\\|"
					   "message\\|"
					   "min\\|"
					   "min_curve_surf\\|"
					   "mk_html_help\\|"
					   "modifyct\\|"
					   "moment\\|"
					   "multi\\|"
					   "n_elements\\|"
					   "n_params\\|"
					   "n_tags\\|"
					   "ncdf_attcopy\\|"
					   "ncdf_attdel\\|"
					   "ncdf_attget\\|"
					   "ncdf_attinq\\|"
					   "ncdf_attname\\|"
					   "ncdf_attput\\|"
					   "ncdf_attrename\\|"
					   "ncdf_close\\|"
					   "ncdf_control\\|"
					   "ncdf_create\\|"
					   "ncdf_dimdef\\|"
					   "ncdf_dimid\\|"
					   "ncdf_diminq\\|"
					   "ncdf_dimrename\\|"
					   "ncdf_exists\\|"
					   "ncdf_inquire\\|"
					   "ncdf_open\\|"
					   "ncdf_vardef\\|"
					   "ncdf_varget\\|"
					   "ncdf_varget1\\|"
					   "ncdf_varid\\|"
					   "ncdf_varinq\\|"
					   "ncdf_varput\\|"
					   "ncdf_varrename\\|"
					   "newton\\|"
					   "norm\\|"
					   "on_error\\|"
					   "on_ioerror\\|"
					   "online_help\\|"
					   "open\\|"
					   "oplot\\|"
					   "oploterr\\|"
					   "p_correlate\\|"
					   "pickfile\\|"
					   "plot\\|"
					   "plot_3dbox\\|"
					   "plot_field\\|"
					   "ploterr\\|"
					   "plots\\|"
					   "pnt_line\\|"
					   "point_lun\\|"
					   "polar_contour\\|"
					   "polar_surface\\|"
					   "poly\\|"
					   "poly_2d\\|"
					   "poly_area\\|"
					   "poly_fit\\|"
					   "polyfill\\|"
					   "polyfillv\\|"
					   "polyfitw\\|"
					   "polyshade\\|"
					   "polywarp\\|"
					   "popd\\|"
					   "powell\\|"
					   "primes\\|"
					   "print\\|"
					   "printd\\|"
					   "profile\\|"
					   "profiles\\|"
					   "project_vol\\|"
					   "ps_show_fonts\\|"
					   "psafm\\|"
					   "pseudo\\|"
					   "pushd\\|"
					   "qromb\\|"
					   "qromo\\|"
					   "qsimp\\|"
					   "r_correlate\\|"
					   "r_test\\|"
					   "randomn\\|"
					   "randomu\\|"
					   "ranks\\|"
					   "rdpix\\|"
					   "read\\|"
					   "read_bmp\\|"
					   "read_gif\\|"
					   "read_interfile\\|"
					   "read_jpeg\\|"
					   "read_pict\\|"
					   "read_ppm\\|"
					   "read_spr\\|"
					   "read_srf\\|"
					   "read_sylk\\|"
					   "read_wave\\|"
					   "read_x11_bitmap\\|"
					   "read_xwd\\|"
					   "reads\\|"
					   "readu\\|"
					   "rebin\\|"
					   "recon3\\|"
					   "reduce_colors\\|"
					   "reform\\|"
					   "regress\\|"
					   "replicate\\|"
					   "resolve_all\\|"
					   "resolve_routine\\|"
					   "restore\\|"
					   "reverse\\|"
					   "riemann\\|"
					   "rk4\\|"
					   "roberts\\|"
					   "rot\\|"
					   "rotate\\|"
					   "round\\|"
					   "rs_test\\|"
					   "rstrpos\\|"
					   "s_test\\|"
					   "save\\|"
					   "scale3\\|"
					   "scale3d\\|"
					   "search2d\\|"
					   "search3d\\|"
					   "set_plot\\|"
					   "set_shading\\|"
					   "setenv\\|"
					   "setup_keys\\|"
					   "sfit\\|"
					   "shade_surf\\|"
					   "shade_surf_irr\\|"
					   "shade_volume\\|"
					   "shift\\|"
					   "show3\\|"
					   "showfont\\|"
					   "sin\\|"
					   "sindgen\\|"
					   "sinh\\|"
					   "size\\|"
					   "slicer\\|"
					   "slide_image\\|"
					   "smooth\\|"
					   "sobel\\|"
					   "sort\\|"
					   "spawn\\|"
					   "sph_4pnt\\|"
					   "sph_scat\\|"
					   "spl_init\\|"
					   "spl_interp\\|"
					   "spline\\|"
					   "spline_p\\|"
					   "sprsab\\|"
					   "sprsax\\|"
					   "sprsin\\|"
					   "sqrt\\|"
					   "stop\\|"
					   "str_sep\\|"
					   "strarr\\|"
					   "strcompress\\|"
					   "stretch\\|"
					   "string\\|"
					   "strlen\\|"
					   "strlowcase\\|"
					   "strmessage\\|"
					   "strmid\\|"
					   "strpos\\|"
					   "strput\\|"
					   "strtrim\\|"
					   "strupcase\\|"
					   "surface\\|"
					   "surfr\\|"
					   "svdc\\|"
					   "svdfit\\|"
					   "svsol\\|"
					   "swap_endian\\|"
					   "systime\\|"
					   "t_cvf\\|"
					   "t_pdf\\|"
					   "t3d\\|"
					   "tag_names\\|"
					   "tan\\|"
					   "tanh\\|"
					   "tek_color\\|"
					   "temporary\\|"
					   "thin\\|"
					   "threed\\|"
					   "tiff_dump\\|"
					   "tiff_read\\|"
					   "tiff_write\\|"
					   "time_test\\|"
					   "tm_test\\|"
					   "total\\|"
					   "transpose\\|"
					   "tri_surf\\|"
					   "triangulate\\|"
					   "trigrid\\|"
					   "triql\\|"
					   "trired\\|"
					   "trisol\\|"
					   "ts_coef\\|"
					   "ts_diff\\|"
					   "ts_fcast\\|"
					   "tv\\|"
					   "tvcrs\\|"
					   "tvlct\\|"
					   "tvrd\\|"
					   "tvscl\\|"
					   "uniq\\|"
					   "usersym\\|"
					   "vel\\|"
					   "velovect\\|"
					   "vert_t3d\\|"
					   "voigt\\|"
					   "voronoi\\|"
					   "voxel_proj\\|"
					   "wait\\|"
					   "warp_tri\\|"
					   "wdelete\\|"
					   "wf_draw\\|"
					   "where\\|"
					   "wided\\|"
					   "widget_base\\|"
					   "widget_button\\|"
					   "widget_control\\|"
					   "widget_draw\\|"
					   "widget_droplist\\|"
					   "widget_event\\|"
					   "widget_info\\|"
					   "widget_label\\|"
					   "widget_list\\|"
					   "widget_message\\|"
					   "widget_slider\\|"
					   "widget_text\\|"
					   "window\\|"
					   "write_bmp\\|"
					   "write_gif\\|"
					   "write_jpeg\\|"
					   "write_nrif\\|"
					   "write_pict\\|"
					   "write_ppm\\|"
					   "write_spr\\|"
					   "write_srf\\|"
					   "write_sylk\\|"
					   "write_wave\\|"
					   "writeu\\|"
					   "wset\\|"
					   "wshow\\|"
					   "wtn\\|"
					   "xbm_edit\\|"
					   "xdisplayfile\\|"
					   "xfont\\|"
					   "xinteranimate\\|"
					   "xloadct\\|"
					   "xmanager\\|"
					   "xmng_tmpl\\|"
					   "xmtool\\|"
					   "xpalette\\|"
					   "xregistered\\|"
					   "xsq_test\\|"
					   "xsurface\\|"
					   "xvaredit\\|"
					   "xyouts\\|"
					   "zoom\\|"
					   "zoom_24"
					   "\\)\\>")   ; End 'concat'
					  'font-lock-reference-face)
					 )  ; End list 'idl-routines-keywords'
				;;
				;;
				;;
				;;
				(setq idl-font-lock-keywords
					 (append 
					  idl-font-lock-keywords
					  (list idl-routines-keywords))
					 )
				) ;End 'progn'
			  ) ; End 'eval-after-load'
