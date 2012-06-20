;; -*-byte-compile-dynamic: t;-*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Custom Functions
;;
;;  Copyright � 1995-2012 John P. Weiss
;;
;;  This package is free software; you can redistribute it and/or modify
;;  it under the terms of the Artistic License, included as the file
;;  "LICENSE" in the source code archive.
;;
;;  This package is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;
;;  You should have received a copy of the file "LICENSE", containing
;;  the License John Weiss originally placed this program under.
;;
;;
;; My custom functions.  Used as tools and bound to keys, or used as
;; autohooks, or just basic building-block functions.
;;
;;
;; $Id$
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'custom-vars)
(eval-when-compile
  (require 'custom-set-defaults)
  (require 'sh-script))


;;----------------------------------------------------------------------
;;
;; Customization/Setup Tools
;;


(defun jpw-win-or-unix (win-val unix-val)
  "Return the appropriate value, depending on which OS we're running in.
{jpw: 09/2006}"
  (if is-winblows
      win-val
    ;; else
    unix-val
    )
  )


(if running-xemacs
    ;; Replace several "missing" GNU Emacs functions
    (progn

      (defun set-face-bold-p (face boldp &rest args)
        "A little placeholder for a GNU Emacs function missing from XEmacs.
Note that this fn. only sets a face bold.  It cannot unset it.
{jpw: 9/2004}"
        (if boldp
            (set-face-font face [bold])
          ;; else
          ;;(set-face-font face [])
          )
        )

      (defun line-beginning-position (&optional n)
        (save-excursion
          (beginning-of-line n)
          (point)
          )
        )

      (defun line-end-position (&optional n)
        (save-excursion
          (end-of-line n)
          (point)
          )
        )

      );;end progn

  ;; else
  (progn
    (defun jpw-cust-colorful-modeline ()
      (require 'custom-set-defaults)

      (let ( (modeline-active-modeflags
              (if is-version-twentytwo
                  '((class color) (min-colors 88))
                ;; else
                t
                );; endif
              )
             (modeline-lowcolor-modeflags
              (if is-version-twentytwo
                  '((class color) (min-colors 8))
                ;; else
                nil
                );; endif
              )
             );; end varbindings

        (jpw-custom-set-faces-nonsaved
         (list 'mode-line
               (list (list modeline-active-modeflags
                           '(:background "plum3"
                                         :foreground "black"
                                         :box (:line-width -1
                                                           :style released-button)))
                     (list modeline-lowcolor-modeflags
                           '(:background "magenta"
                                         :foreground "black"))
                     )
               nil
               "For when I'm in the mood for a more colorful modeline, use
                this."
               )
         '(mode-line-highlight
           ((t (:foreground "green4"
                            :box (:line-width 2 :color "grey40" :style released-button))))
           nil
           "Just using a box with a darker gray is unsatisfying.  Let's
            change the text color to something that will stand out (but not
            water our eyes).  Change the modeline color, and we may need to
            change this."
           )
         (list 'mode-line-inactive
               (list (list modeline-active-modeflags
                           '(:inherit mode-line
                                      :background "LemonChiffon3"
                                      :foreground "grey20"
                                      :box (:line-width -1 :style released-button)
                                      :weight light))
                     (list modeline-lowcolor-modeflags
                           '(:inherit mode-line
                                      :background "gray"))
                     )
               nil
               "To accompany my more colorful modeline, I'll pick an off-white
            color for the inactive modeline."
               )
         )
        );; end let
      )
    );; end progn:  else

  );; end if running-xemacs


;;----------------------------------------------------------------------
;;
;; Building Blocks
;;


(defsubst jpw-insert-markup-tags (start-tag end-tag)
  "Inserts the two markup tags, `start-tag' and `end-tag', on either side of
`point'.  If a region is active, it inserts the two tags on either side of the
region.
{jpw: 2/2005}"
  (let* ((start-tag-point (or (and mark-active (region-beginning))
                              (point)))
         (end-tag-point (or (and mark-active (region-end))
                            (point)))
         (must-pop-mark mark-active)
         );end bindings
    (if mark-active (push-mark))
    (save-excursion
      ;; Insert end tag first to preserve position of start tag.
      (goto-char end-tag-point)
      (insert end-tag)
      (goto-char start-tag-point)
      (insert-before-markers start-tag)
      );end excursion
    (if must-pop-mark (pop-mark))
    t ;; To keep the message buffer quiet (`pop-mark' is noisy).
    );end let
  )


(defun jpw-insert-xml-tag (tag)
  "Inserts the begin- and end-tags for the XML entity named `tag', inserting
them on either side of `point'.  If a region is active, it inserts the two
tags on either side of the region.
{jpw: 2/2005}"
  (jpw-insert-markup-tags (concat "<" tag ">") (concat "</" tag ">"))
  )


;;----------------------------------------------------------------------
;;
;; Editing Tools
;;


(defun ebuffer-files (buffer-A buffer-B &optional startup-hooks job-name)
  "Like `ebuffers', does an `ediff' on the two buffers underlying files.
{jpw: 9/2006}"
  ;; [jpw] Stolen lock, stock, and barrel from "ediff.el"
  (interactive
   (let (bf)
     ;; [jpw] This "if"-block is my own custom tweak.
     (if (not (and (functionp 'ediff-files)
                   (functionp 'ediff-other-buffer)
                   )
              )
         (load "ediff")
       )
     (list (setq bf (read-buffer "Buffer A to compare: "
                                 (ediff-other-buffer "") t))
           (read-buffer "Buffer B to compare: "
                        (progn
                          ;; realign buffers so that two visible bufs will be
                          ;; at the top
                          (save-window-excursion (other-window 1))
                          (ediff-other-buffer bf))
                        t))))
  (ediff-files (buffer-file-name (get-buffer buffer-A))
               (buffer-file-name (get-buffer buffer-B))
               startup-hooks)
  )


(defun kill-ring-save-entire-buffer ()
  "Like kill-ring-save, but grabs the entire buffer."
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "Saved all (visible) buffer text.")
  )


(defun join-next-line ()
  "Join the current line to the next line.
{jpw: 2/1999}"
  (interactive)
  (end-of-line)
  (let ((oldeolpos (point)))
    (forward-line 1)
    (back-to-indentation)
    (delete-region oldeolpos (point))
    )
  )


(defun reverse-indent-line ()
  "Remove a level of indentation from the current line.
{jpw: 10/2001}"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((bolp (point)))
      (back-to-indentation)
      (indent-rigidly bolp (point) (- 0 tab-width))
      ); end let
    ); end excursion
  )


(defun unindent-line ()
  "Remove all indentation from the current line.
{jpw: 12/1999}"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((bolp (point)))
      (back-to-indentation)
      (delete-region bolp (point))
      ); end let
    ); end excursion
  )


(defun untabify-buffer ()
  "Untabify the current buffer.
{jpw: 12/1998}"
  (interactive)
  (untabify (point-min) (point-max))
  )


(defun tabify-buffer ()
  "Untabify the current buffer.
{jpw: 09/2008}"
  (interactive)
  (tabify (point-min) (point-max))
  )


(defun jpw-correct-tabs ()
  "If `indent-tabs-mode' is true, calls `tabify-buffer', otherwise, it calls
`untabify-buffer'.

Designed for use as a `before-save-hook'.
{jpw: 06/2012}"
  (interactive)
  (if indent-tabs-mode
      (tabify-buffer)
    ;; else
    (untabify-buffer)
    )
  )


(defun jpw-clean-trailing-whitespace ()
  "Removes all whitespace at the end of every line.

Designed for use as a `before-save-hook'.
{jpw: 06/2012}"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    ;; From the fn. documentation for `perform-replace':
    (while (re-search-forward "[ \t]+$" nil t)
      (replace-match "" nil nil))
    );;end excursion
  )


(defvar jpw-correct-tabs-on-save t
  "If set non-nil, causes `save-buffer-tab-consistent' and
`kill-buffer-tab-consistent' to convert all leading whitespace to
space-characters or tabs.  Which it converts to depends on the value of
`indent-tabs-mode'.
{jpw; 09/2008}")


(defun save-buffer-tab-consistent ()
  "Saves the current buffer, (un)tabifying it beforehand.

If `indent-tabs-mode' is true, calls `tabify-buffer' before saving.
Otherwise, it calls `untabify-buffer'.
{jpw: 09/1998}"
  (interactive)
  (if jpw-correct-tabs-on-save
      (if indent-tabs-mode
          (tabify-buffer)
        ;; else
        (untabify-buffer)
        )
    )
  (save-buffer)
  )


(defun server-quit-l ()
  "Saves the server-buffer, does a (server-edit), then kills the
buffer.
{jpw: 11/2004}"
  (interactive)
  (save-buffer)
  (if (not (or is-winblows is-cygwin))
      (progn
        (rename-buffer "oldserv")
        (server-edit)
        (switch-to-buffer "oldserv")
        ));; end if...progn
  (kill-this-buffer)
  )


(defun kill-buffer-other-window ()
  "Kill the buffer in the next open window.
{jpw: 12/2004}"
  (interactive)
  (other-window 1)
  (kill-this-buffer)
  (other-window -1)
  )


(defun kill-next-buffer-and-close-other-windows ()
  "Kill the buffer in the next open window, then close all of the other
windows.
{jpw: 2/2005}"
  (interactive)
  (other-window 1)
  (kill-this-buffer)
  (other-window -1)
  (delete-other-windows)
  )


(defun bury-buffer-other-window ()
  "Bury the buffer in the next open window.
{jpw: 12/2004}"
  (interactive)
  (other-window 1)
  (bury-buffer)
  (other-window -1)
  )


(defun switch-to-buffer-using-other-window (buffer)
  "Custom version of `switch-to-buffer-other-window' that remains in the
current window instead of switching.
{jpw: 12/2004}"
  (interactive "BOpen buffer in other window: ")
  (switch-to-buffer-other-window buffer)
  (other-window -1)
  )


(defun find-file-using-other-window (buffer)
  "Custom version of `find-file-other-window' that remains in the
current window instead of switching.
{jpw: 12/2004}"
  (interactive "FFind file in other window: ")
  (find-file-other-window buffer)
  (other-window -1)
  )


(defun kill-buffer-then-find-file (nubuffer)
  "Open the specified file in the current active window, first killing
whatever buffer is presently open.
{jpw: 2/2005}"
  (interactive "FKill this buffer, then find file: ")
  (kill-this-buffer)
  (find-file nubuffer)
  )


(defun switch-to-self-other-window ()
  "As the name implies.  Useful when working on a long piece of sourcecode.
{jpw: 12/2004}"
  (interactive)
  (let ((mybufname (current-buffer))
        );;end let-varlist
    (switch-to-buffer-using-other-window mybufname)
    );;end let
  )


(defun save-all-buffers ()
  "{jpw: 12/2004}"
  (interactive)
  (save-some-buffers t)
  )


(defun dos2unix-buffer ()
  "Convert a DOS buffer to raw unix text
{jpw: 5/2000}."
  (interactive)
  (set-buffer-file-coding-system 'raw-text-unix nil))


(defun unix2dos-buffer ()
  "Convert a DOS buffer to raw unix text
{jpw: 11/2000}."
  (interactive)
  (set-buffer-file-coding-system 'raw-text-dos nil))


(defun jpw-session-reload ()
  "Reload the files from a previous session.  Will invoke `session-initialize'
if not done already.
{jpw:  8/2010}"
  (interactive)
  (and

   (if (not (boundp 'session-file-alist))
       ;; Ensure that we proceed only if we load and init the session pkg.
       (and
        (require 'session)
        (session-initialize)
        );; end and
     ;; else
     t
     );; end if

   (let (jpw-session-filespec
         jpw-session-filename)

     (dolist (jpw-session-filespec session-file-alist)
       (setq jpw-session-filename (car jpw-session-filespec))
       (and
        (file-exists-p jpw-session-filename)
        (find-file-existing jpw-session-filename)
        )
       ;; No need to restore the point & mark; `session-find-file-hook' (which
       ;; `session-initialize' adds to `find-file-hooks') will do this and
       ;; more for us.

       );; end dolist
     );; end let

   );; end outer-and
  )


(defun jpw-session-save ()
  "Call `session-save-session' with completely \"fresh state\".  The old
`session-save-file' is deleted and the variable `session-file-alist' erased.

{Note:  Previously-killed buffers are all stored in `session-file-alist'.
        Erasing it first ensures that only the open buffers are stored.}
{Note2:  `session-save-session' appears to delete any existing
         `session-save-file'.  Well, the present version of \"session.el\"
         appears to.  But this defun also deletes `session-save-file', just to
         be on the safe side.}

Use it to save a clean session.
{jpw:  8/2010}"
  (interactive)
  (and
   (boundp 'session-use-package)
   (boundp 'session-file-alist)
   (let ((old-sess-undo-chk session-undo-check))
     (setq session-file-alist nil
           session-undo-check -65536)
     (delete-file session-save-file)
     (session-save-session)
     (setq session-undo-check old-sess-undo-chk)
     )
   )
  )


(defun jpw-init-session-mgmt ()
  "Load the \"session\" package and set up use of my `jpw-session-save' and
'jpw-session-load' defuns for saving and loading session.
{jpw:  7/2011}"
  (interactive)

  (require 'session)
  (remove-hook 'kill-emacs-hook 'session-save-session)
  (add-hook 'kill-emacs-hook 'jpw-session-save)
  (add-hook 'emacs-startup-hook 'jpw-session-reload)
  (global-set-key [?\C-c \S-f9] 'jpw-session-save)
  (global-set-key [?\C-c \M-f10] 'jpw-session-reload)
  )


;;----------------------------------------------------------------------
;;
;; Custom Behavior
;;
;; Activate behaviors not used regularly, but used nonetheless.
;;


(defun jpw-read-info-dir(file)
  "Invoke Info on the named file, which should be a .info file or info
top-level directory file."
  (interactive "fInfo file to open: ")
  (find-file file)
  (Info-on-current-buffer)
  )


(defun set8tab ()
  "Sets tab width to 8
{jpw: 7/2000}."
  (interactive)
  (setq tab-width 8)
  (recenter))


(defun set4tab ()
  "Sets tab width to 4
{jpw: 7/2000}."
  (interactive)
  (setq tab-width 4)
  (recenter))


(defun c-no-comment-stars ()
  (interactive)
  ;; For Emacs 20.* or earlier
  ;  (setq c-comment-continuation-stars "")
  (setq c-block-comment-prefix "")
  )


(defun do-comment-line-break ()
  "Calls the function that the variable `comment-line-break-function'
is set to
{jpw: 3/2002}."
  (interactive)
  (funcall comment-line-break-function))


(defvar jpw-utf-in-use nil
  "Used internally.  Do not modify.  {jpw; 03/2007}")
(defun jpw-load-utf()
  "Force use of Mule UTF encodings. {jpw; 11/2005}"
  (interactive)
  (if (boundp 'mule-version)
      (setq jpw-utf-in-use t)
    )
  (if (not jpw-utf-in-use)
      (progn
        ;; Taken from `loadup.el'
        (load "international/mule")
        (load "international/mule-conf.el") ; Don't get confused if someone
        ; compiled this by mistake.
        (load "international/mule-cmds")
        (load "case-table")
        (load "international/utf-8")
        (load "international/utf-16")
        (load "international/characters")
        (load "international/ucs-tables")
        (setq jpw-utf-in-use t)
        )
    )
  )


(defun decode-utf16 ()
  "Decode a buffer in utf-16
{jpw: 11/2005}."
  (interactive)
  (jpw-load-utf)
  (decode-coding-region (point-min) (point-max)
                        'mule-utf-16-le-with-signature))
(defalias 'decode-xml 'decode-utf16)


(defun decode-entire-buffer-utf8 ()
  "Decode a buffer in utf-8
Unfortunately, it doesn't work too well.

{jpw: 03/2007}."
  (interactive)
  (jpw-load-utf)
  (decode-coding-region (point-min) (point-max) 'mule-utf-8))


(defun revert-to-utf8 ()
  "Reread the current buffer, using utf-8 encoding this time.
Unfortunately, it doesn't work too well.

{jpw: 03/2007}."
  (interactive)
  (jpw-load-utf)
  (revert-buffer-with-coding-system 'mule-utf-8)
  ;;(let ((my-file-name (buffer-file-name (current-buffer)))
  ;;      ;; Set this only for the duration of the scope of the (let ...).
  ;;      (coding-system-for-read 'mule-utf-8)
  ;;      (coding-system-for-write 'mule-utf-8)
  ;;      );; end varbindings
  ;;  (find-alternate-file my-file-name)
  ;;  )
  ;;(setq buffer-file-coding-system 'mule-utf-8)
  )


(defun use-utf8 ()
  "Use the utf-8 encoding system in this buffer.  Does so by performing a
`revert-to-utf8'.

{jpw: 05/2008}."
  (interactive)
  (jpw-load-utf)
  (revert-buffer-with-coding-system 'mule-utf-8)
  (setq buffer-file-coding-system 'mule-utf-8)
  )


(defun jpw-sh-mode-font-lock-enhance ()
  "Modify the variable `sh-font-lock-keywords-var' to correctly highlight
function definitions in bash and ksh.

{jpw:  08/2010}"
  (let ((font-lock-sh-fn-name-keywords
         ;; Function names.  Taken from sh-script.el
         (list
          '("^\\(\\sw+\\)[ \t]*(" 1 font-lock-function-name-face)
          '("\\<\\(function\\)\\>[ \t]*\\(\\sw+\\)?"
            (1 font-lock-keyword-face) (2 font-lock-function-name-face nil t))
          ))
        (modified-keywords-var (list))
        shell-specific-keywords
        shell-type
        new-keyword-regex
        ) ;; end varbindings

    (dolist (shell-specific-keywords sh-font-lock-keywords-var)
      (setq shell-type (car shell-specific-keywords))
      (if (or (equal shell-type 'bash)
              (equal shell-type 'ksh)
              (equal shell-type 'ksh88))
          (dolist (new-keyword-regex font-lock-sh-fn-name-keywords)
            (add-to-list 'shell-specific-keywords new-keyword-regex 't)
            )
        ) ;;end if
      (add-to-list 'modified-keywords-var shell-specific-keywords 't)
      )
    (setq sh-font-lock-keywords-var modified-keywords-var)
    ) ;; end let
  )


;;----------------------------------------------------------------------
;;
;; Unfill Paragraph Functions
;;


(defsubst jpw-unfill-paragraph-engine (remove-blank-lines
                                       jpw-unfill-skip-line)
  "Takes paragraphs separated by blank lines and merges the paragraph into a
single line.  The inter-paragraph blank lines are preserved by default.

Evaluates to `nil' if this is the current paragraph is the last paragraph in
the buffer.  Evaluates to `t' otherwise.

When `remove-blank-lines' is `t', all consecutive inter-paragraph blank lines
{i.e. empty lines} will be removed.  If set to `collapse', the consecutive
inter-paragraph blank lines will be collapsed into a single blank line.  If
set to `first', the first inter-paragraph blank line will be removed.  The
others will be left alone.

`jpw-unfill-skip-line' should be either nil or the name of a function to
call.  The function will take a single arg, the position of the first
non-whitespace character on a line.  If that line should not be unfolded into
the preceding one, the function specified in `jpw-unfill-skip-line' must eval
to `nil'.
{jpw: 03/2006}"
  (save-excursion
    ;; Position at 1st char of the paragraph proper.
    (backward-paragraph)
    (if (not (bobp))
        (forward-char))
    (end-of-line)
    ;; Main Loop
    (while (looking-at "\n\\([ \t]*\\)\\([^ \t\n]\\)")
      (if (and (functionp jpw-unfill-skip-line)
               (funcall jpw-unfill-skip-line (match-beginning 2)))
          (forward-line)
        ;; else:
        ;; Merge the two lines.
        (if (not (or (= (preceding-char) ?\ )
                     (= (preceding-char) ?\t)))
            ;; Insert two spaces after '.' or ':'.
            (if (or (= (preceding-char) ?.)
                    (= (preceding-char) ?:))
                (replace-match "  \\2")
              ;; else:
              ;; Other non-whitespace char.  Only put in one space.
              (replace-match " \\2")
              ) ;; end punct-if
          ;; else:
          ;; Already contains a separating whitespace char.
          (replace-match "\\2")
          ) ;;end space-if
        );; end skip-line-if
      (end-of-line)
      );;end Main Loop
    (cond ((eq remove-blank-lines 'collapse)
           (if (looking-at "\n\n\n+")
               (replace-match "\n\n"))
           )
          ((eq remove-blank-lines 'first)
           (if (looking-at "\n\n")
               (replace-match "\n"))
           )
          (remove-blank-lines
           (if (looking-at "\n\n+")
               (replace-match "\n"))
           )
          );; end cond
    );;end excursion
  (not (eobp))
  )


(defsubst jpw-unfill-buffer-engine (remove-blank-lines jpw-unfill-skip-line)
  "Calls `jpw-unfill-paragraph-engine' on every paragraph in the buffer (or
the narrowed region).

The optional `remove-blank-lines' will be passed to every underlying
`jpw-unfill-paragraph-engine' call.
{jpw: 09/2005}"
  (save-excursion
    (goto-char (point-min))
    (while (jpw-unfill-paragraph-engine remove-blank-lines
                                        jpw-unfill-skip-line)
      (forward-word 1)
      );; end while.
    );; end excursion
  )


(defun jpw-unfill-paragraph (&optional remove-blank-lines)
  "Takes paragraphs separated by blank lines and merges the paragraph into a
single line.  The inter-paragraph blank lines are preserved by default.

Evaluates to `nil' if this is the current paragraph is the last paragraph in
the buffer.  Evaluates to `t' otherwise.

If `remove-blank-lines' is non-nil, the inter-paragraph blank lines will
be removed completely.  {See `jpw-unfill-paragraph-engine' for more possible
values of `remove-blank-lines'.}
{jpw: 03/2006}"
  (interactive "P")
  (jpw-unfill-paragraph-engine remove-blank-lines nil)
  )


(defsubst jpw-unfill-buffer (&optional remove-blank-lines)
  "Calls `jpw-unfill-buffer-engine' on every paragraph in the buffer (or
the narrowed region).

The optional `remove-blank-lines' will be passed to
`jpw-unfill-buffer-engine'.  See `jpw-unfill-paragraph-engine' for further
details regarding this arg.
{jpw: 09/2005}"
  (interactive "P")
  (jpw-unfill-buffer-engine remove-blank-lines nil)
  )


;;----------------------------------------------------------------------
;;
;; Code-Doc defuns. & consts.
;;


(defconst jpw-doxy-cxx-start-re "^ *///"
  "Regular expression matching the start of a Doxygen or Javadoc-style comment
line.
{jpw: 12/2011}"
  )


(defconst jpw-doxy-block-start-re "^ */\\(\*\*\\|//\\)"
  "Regular expression matching the start of a Doxygen or Javadoc-style comment
line.
{jpw: 12/2011}"
  )


(defconst jpw-doxy-line-start-re "^ *\\(\*+\\|///\\)\\( *\\)"
  "Regular expression matching the start of a Doxygen or Javadoc-style comment
line.
{jpw: 12/2011}"
  )


(defconst jpw-doxy-empty-line-re (concat jpw-doxy-line-start-re "$")
  "Regular expression for an empty (except for whitespace)
Doxygen or Javadoc-style comment line.
{jpw: 12/2011}"
  )


(defconst jpw-javadoc-invalid-chars-table
  '(
    ("<" . "&lt;")
    (">" . "&gt;")
    ("&" . "&amp;")
    ("@" . "&#064;")
    )
  "Table of characters that can't be used in Javadoc comments, mapped to their
replacements.
{jpw; 02/2012}")


(defconst jpw-javadoc-invalid-chars-re  "[<>&@]"
  "Regexp of characters that can't be used in Javadoc comments.
{jpw; 02/2012}")


(defconst jpw-javadoc-invalid-nontag-chars-re  "[&@]"
  "Regexp of characters that can't be used in Javadoc comments, minus '<' and
'>'
{jpw; 02/2012}")


(defconst jpw-javadoc-chk-invalid-start-re
  (concat "\\({@link\\|"
          jpw-javadoc-invalid-nontag-chars-re
          "\\|<\\(?:code\\|pre\\)>\\)")
  "Regexp for text that marks the beginning of a block of Javadoc which
might contain invalid characters.
{jpw; 02/2012}")


(defconst jpw-javadoc-chk-invalid-end-re
  "\\(?:}\\|</\\(?:code\\|pre\\)>\\)"
  "Regexp for text that marks the end of a block of Javadoc which
might contain invalid characters.
{jpw; 02/2012}")


(defconst jpw-javadoc-replacement-entity-re
  "&\\(?:lt\\|gt\\|amp\\|#[0-9]+\\);"
  "Regexp matching any of the HTML entities from
`jpw-javadoc-invalid-chars-table'.  Also matches any numeric HTML entities.
{jpw; 02/2012}")


(defun jpw-insert-doc-unitag (tagname)
  "Insert an HTML tag that is self-closing.
{jpw: 07/2004}"
  (interactive "*sEnter HTML tag: ")
  (insert "<" tagname "/>")
  )


(defun jpw-insert-doc-tag (tagname)
  "Insert a doxygen/javadoc HTML style/font tag pair.
{jpw: 07/2004}"
  (interactive "*sEnter HTML tag: ")
  (jpw-insert-xml-tag tagname)
  )


(defun jpw-insert-doc-tagblock (tagname)
  "Insert a doxygen/javadoc HTML style/font tag pair block, with each tag on
its own comment line.  Opens a new comment line if the current one contains
anything.
{jpw: 07/2004}"
  (interactive "*sEnter HTML tag: ")
  (if mark-active
      ;; When the user marks a region, assume that they want to enclose it w/o
      ;; inserting breaks anyplace.
      ;; Note that `jpw-insert-xml-tag' unsets the mark.
      (jpw-insert-xml-tag tagname)

    ;; else
    (let* ((on-blank-line (save-excursion
                            (beginning-of-line)
                            (looking-at jpw-doxy-empty-line-re))
                          )
           (needs-a-space (and on-blank-line
                               (not (= (preceding-char) ?\ )))
                          )
           (has-text-following (not (looking-at "$"))
                               )
           );; end varbindings
      ;; Body
      (if needs-a-space
          (insert " ")
        ;; else
        (if (not on-blank-line)
            (do-comment-line-break))
        )
      (if has-text-following
          (save-excursion (do-comment-line-break)))
      );;end let*

    (jpw-insert-xml-tag tagname)

    (do-comment-line-break)
    (do-comment-line-break)
    (forward-line -1)
    (end-of-line)
    (insert " ")
    );;end if
  );;end defun


(defun jpw-insert-doc-nested-tagblock (outertagname innertagname)
  "Insert two doxygen/javadoc HTML style/font tags, the second nested inside
the first.  The first is inserted as a block.
{jpw: 01/2009}"
  (interactive)
  (jpw-insert-doc-tagblock outertagname)
  (do-comment-line-break)
  (insert-char ?. 1)
  (save-excursion
    (do-comment-line-break)
    )
  (delete-char -1)
  (jpw-insert-doc-tag innertagname)
  )


(defun jpw-insert-doxygen-cmdblock (cmdname)
  "Insert a doxygen '\\command'...'\\endcommand' pair on separate lines.
{jpw: 07/2004}"
  (interactive "*sEnter doxygen command: ")
  (do-comment-line-break)
  (insert "\\" cmdname)
  (do-comment-line-break)
  (save-excursion
    (do-comment-line-break)
    (insert "\\end" cmdname)
    (do-comment-line-break))
  )


(defun jpw-insert-javadoc-link ()
  "Insert a javadoc '@link' field
{jpw: 07/2004}"
  (interactive)
  (if mark-active
      (save-excursion
        (goto-char (region-beginning))
        (if (search-forward "." (region-end) t)
            (replace-match "#" nil t)
          )
        )
    )
  (jpw-insert-markup-tags "{@link " "}")
  )


(defun jpw-insert-javadoc-member-link ()
  "Insert a javadoc '@link' field for a member
{jpw: 01/2009}"
  (interactive)
  (jpw-insert-markup-tags "{@link #" "}")
  )


(defsubst jpw-cleanup-javadoc-do-replace ()
  (let ((entity (cdr (assoc (match-string 0)
                            jpw-javadoc-invalid-chars-table)))
        );;end bindings
        (if (looking-at jpw-javadoc-replacement-entity-re)
            (goto-char (match-end 0))
          ;; else
          (replace-match entity t t))
        );;end let
  )


(defun jpw-cleanup-javadoc-region (start-mark end-mark)
  "Replace the following characters between the markers `start-mark' and
`end-mark':
    '<' with '&gt;'
    '>' with '&lt;'
    '&' with '&amp;'
    '@' with '&#064;'
{jpw: 02/2012}"

  (if (< end-mark start-mark)
      ;; Exchange marks that are out of order.
      (let ((swap-mark end-mark))
        (setq end-mark start-mark
              start-mark swap-mark)
      )
    )

  (save-excursion
    (goto-char (marker-position start-mark))
      (while (re-search-forward jpw-javadoc-invalid-chars-re
                                (marker-position end-mark)
                                t)
        (goto-char (match-beginning 0))
        (jpw-cleanup-javadoc-do-replace)
        );;end while
      );;end excursion
  )


(defun jpw-cleanup-javadoc-block ()
  "Replace the following characters in code samples in the current region:
    '<' with '&gt;'
    '>' with '&lt;'
    '&' with '&amp;'
    '@' with '&#064;'

Anything inside of '<code> ... </code>', '<pre> ... </pre>',
or '{@link ... }' is considered a code sample.  Text outside of these blocks
is ignored.

{jpw: 02/2012}"

  (interactive)
  (if mark-active
      (let ((jdb-start (region-beginning))
            (jdb-end (region-end))
            (subblock-start-mark (make-marker))
            (subblock-end-mark (make-marker))
            match-end-start-re);;end bindings
        (save-excursion
          (goto-char jdb-start)
          (while (re-search-forward jpw-javadoc-chk-invalid-start-re
                                    jdb-end
                                    t)
            (setq match-end-start-re (match-end 0))
            (goto-char (match-beginning 0))
            (if (looking-at jpw-javadoc-invalid-nontag-chars-re)
                (jpw-cleanup-javadoc-do-replace)
              ;; else
              (goto-char match-end-start-re)
              (set-marker subblock-start-mark match-end-start-re)
              (set-marker subblock-end-mark
                          (if (re-search-forward
                               jpw-javadoc-chk-invalid-end-re
                               jdb-end
                               t)
                              (match-beginning 0)
                            ;; else
                            jdb-end)
                          )
              (jpw-cleanup-javadoc-region subblock-start-mark
                                          subblock-end-mark)
              );;end if
            );;end while

          ;; If 'match-end-start-re' was never set, try cleaning up the region
          ;; itself.
          (if (not match-end-start-re)
              (progn
                (set-marker subblock-start-mark jdb-start)
                (set-marker subblock-end-mark jdb-end)
                (jpw-cleanup-javadoc-region subblock-start-mark
                                            subblock-end-mark)
                );;end progn
            )
          );;end excursion
        );;end let
    )
  )


(defun jpw-c-fill-paragraph (&optional start-at end-at arg)
  "Nearly-identical to `c-fill-paragraph', but recognizes an active region and
restricts the fill to it.

ARG is passed directly to `c-fill-paragraph'.

START-AT and END-AT are optional points to restrict `c-fill-paragraph' to, in
lieu of creating an active region.  If a region is active and both START-AT
and END-AT are non-`null', they override the region.

{jpw: 02/2012}"
  (interactive)

  ;; Clear `start-at' if there's no `end-at'.
  (if (not end-at) (setq start-at nil))

  ;; Use the mark if bounds aren't specified.
  (if (and mark-active
           (not start-at))
      (setq start-at (region-beginning)
            end-at (region-end))
    )

  (if start-at
      (save-excursion
        (save-restriction
          (narrow-to-region start-at end-at)
          (goto-char start-at)
          (c-fill-paragraph arg)
          )
        )
    ;; else
    ;; Just call it directly.
    (c-fill-paragraph arg)
    )
  )


(defun jpw-abbrev-indent-doc-block ()
  "Used by abbrev-tables to correctly indent a recently-added comment block.
`point' should be immediately after the comment-ending \"*/\".
{jpw: 12/2011}"
  (interactive)
  (let* ((doxy-region-end (point))
         (comment-block-start-line (save-excursion
                                     (beginning-of-line)
                                     (while (not (looking-at
                                                  jpw-doxy-block-start-re))
                                       (forward-line -1)
                                       (beginning-of-line)
                                       )
                                     (point)
                                     );;end excursion
                                   )
         (initial-cxx-comment-pos (save-excursion
                                    (goto-char comment-block-start-line)
                                    (forward-line -1)
                                    (beginning-of-line)
                                    (if (looking-at jpw-doxy-cxx-start-re)
                                        (point))
                                    );;end excursion
                                  )
         (doxy-region-start (or initial-cxx-comment-pos
                                comment-block-start-line)
                            )
         );;end varbindings

    ;; Body
    (indent-region doxy-region-start doxy-region-end nil)
    );;end let*

  ;; Lastly, delete any space char left on the last line by the abbrev-mode
  ;;mechanism.
  (if (= (preceding-char) ?\ )
      (delete-char -1)
    )
  );;end defun


(defun jpw-abbrev-post-insert (&optional nBack)
  "Used by abbrev-tables after inserting inlined HTML tags.
Moves back by NBACK characters and removes the space character that expanded
the abbreviation (if that's the character that did so).

If NBACK is nil, uses `re-search-backward' to look for the first
occurrence of '> </' before the beginning of the line.  The cursor is placed
between the tags if found, and the space (if present) is removed.

So, if your abbreviation inserts a complex string, call this defun with an
explicit NBACK value (from inside of a `lambda' function).

{jpw: 06/2012}"
  (interactive)
  (if (not nBack)

      (let ((origPos (point))
            (bolp (save-excursion (beginning-of-line)
                                  (point)))
            );; end varbindings
        (if (re-search-backward "> ?</" bolp t)
            (forward-char)
          )
        (if (= (following-char) ?\ )
            (delete-char 1)
          )
        );; end let

    ;; else:
    (backward-char nBack)
    ;; Delete any space char left on the last line by the abbrev-mode
    ;;mechanism.
    (if (= (preceding-char) ?\ )
        (delete-char -1)
      )
    );; end outer-if

  );; end defun


(defun jpw-abbrev-insert-doc-par ()
  "Used by abbrev-tables to insert a \"<p>...</p>\" block.
{jpw: 12/2011}"
  (jpw-insert-doc-tagblock "p")
  (delete-char -1)
  )


(defun jpw-abbrev-insert-doc-pre ()
  "Used by abbrev-tables to insert a \"<pre>...</pre>\" block.
{jpw: 12/2011}"
  (jpw-insert-doc-tagblock "pre")
  (delete-char -1)
  )


;;----------------------------------------------------------------------
;;
;; Autohook-specific functions.
;;


(defun jpw-flip-to-mode (regex mode)
  "Flip from `sh-mode' for embedded \"foreign\" scripting languages.

There's a common technique used for scripts whose interpreter cannot be
started via the \"#!\"-technique:  call 'exec' on the interpreter, passing the
script itself.  This only works with scripting languages that also use the
\"#\" character to start comments and which permit comment lines to be
extended using an EOL-\"\\\"-char.

{jpw; 12/2004}"
  (and
   (save-excursion
     (goto-char (point-min))
     (and (re-search-forward "^#.*\\\\[ \t]*$" (point-max) t)
          (or (beginning-of-line) t)
          (re-search-forward
           (concat "\\\\[ \t]*\nexec .*"
                   regex
                   ".* \\(`basename \\)?\"?\\${?0}?\"?`?"
                   " .*\"?\\${?[@*1]}?\"?")
           (point-max) t)
          ))
   (funcall mode)
   )
  )


(provide 'custom-defuns)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End
;;