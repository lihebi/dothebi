; -*- mode: Lisp;-*-
;;; .stumpwmrc --- StumpWM Init File

;; https://github.com/ivoarch/.dot-org-files/blob/master/stumpwm.org

;; (in-package :stumpwm)

;; set contrib dir
;; (set-contrib-dir "~/.stumpwm.d/contrib/util")

;; disable welcome message
(setf *startup-message* nil)

;; configure swank
;; https://common-lisp.net/project/slime/
;; https://github.com/slime/slime

;; (load "~/.emacs.d/elpa/slime-20140420.33/swank-loader.lisp")
;; (swank-loader:init)
;; (defcommand swank () ()
;;   "Creates a swank server in the stumpwm lisp process"
;;   (setf stumpwm:*top-level-error-action* :break)
;;   (swank:create-server :port 4005
;;            :style swank:*communication-style*
;;            :dont-close t)
;; (echo-string (current-screen)
;;          "Starting swank. M-x slime-connect RET RET, then (in-package stumpwm)."))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode Line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default timeout
;; (setf *mode-line-timeout* 1)

;; smart modeline
(if (not (head-mode-line (current-head)))
    (toggle-mode-line (current-screen) (current-head)))

;; BG time
(defun pretty-time ()
  "Returns the date formatted as '17:19:51 Неделя, 27 Април 2014'."
  (defun stringify-dow (dow)
    (nth dow '("Monday" "Tuesday" "Wednesday" "Thurday" "Friday" "Saturday" "Sunday")))
  (defun stringify-mon (mon)
    (nth (- mon 1) '("Jan" "Feb" "March" "April"
                     "May" "Jun" "Jul" "Aug"
                     "Sep" "Oct" "Nov" "Dec")))
(multiple-value-bind (sec min hr date mon yr dow dst-p tz)
      (get-decoded-time)
    (format NIL "~2,'0d:~2,'0d:~2,'0d ~a, ~d ~a ~d (GMT ~@d)"
            hr min sec
            (stringify-dow dow)
            date (stringify-mon mon)
             yr (- tz))))


;; Modeline format
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W " ; groups/windows
            "^>" ; right align
            " ^7* " '(:eval (pretty-time)); date
            ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the font for the message bar and input bar.
;; 1. Load module for xft fonts.
;; This load failed no matter how. The load of other modules such as "cpu" succeeded
;; (load-module "ttf-fonts")
;; 2. Set xft font.
;; (set-font (make-instance 'ttf-fonts:open-font :family "Source Code Pro" :subfamily "Regular" :size 13))

;; (set-font "-misc-courier-*-*-*--26-*-*-*-c-60-iso8859-1")
;; (set-font "6x13")

;; Finally, I can only use "XLFD" ("X Logical Font Description") fonts
;; this is done by xfontsel or xlsfonts
;; this is the biggest nick name from xlsfonts | grep x
(set-font "12x24")


;; (set-font (open-font "Source Code Pro"))

;; (setf *mode-line-border-width* 100)
;; (setf *mode-line-border-color* "green")
;; (setf *mode-line-pad-x* 30)
;; (set-font "Source Code Pro-28")
;; (set-font "DejaVu Sans Mono")
;; (set-font "xft:DejaVu Sans")
;; (set-font "-*-terminus-*-*-*-*-18-*-*-*-*-*-iso8859-*")

;; (set-font "-*-*-*-*-*-*-10-*-*-*-*-*-*-*")

;; (set-font "-adobe-courier-*-*-*-*-34-*-*-*-*-*-*-*")







;; (set-fg-color "white")
;; (set-bg-color "grey20")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Group/window format
(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")

;; Window gravity
;; (setf *message-window-gravity* :top-right)
;; (setf *input-window-gravity* :top-right)

;; Default border style
;; (setq *window-border-style* :thin)

;; I like 3 seconds for messages.
;; (setf *timeout-wait* 5)

;; Mouse focus by click.
(setf *mouse-focus-policy* :click)
;; Create groups
(setf (group-name (first (screen-groups (current-screen)))) "Default")
(gnewbg-float "Float")

;; Shell program used by run-shell-command
;; (setq *shell-program* (stumpwm::getenv "SHELL"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; run-or-raise - emacs
;; run-or-raise - conkeror
;; run-or-raise - urxvt/screen
;; show dropbox status
;; toggle on=|=off modeline

(defcommand emacs-with-server () ()
  "run-or-raise emacs"
  (run-or-raise "emacsclient -ca emacs" '(:class "Emacs")))
(define-key *root-map* (kbd "e") "emacs-with-server")
(define-key *root-map* (kbd "C-e") "emacs-with-server")

(defcommand browser () ()
  "run or raise conkeror"
  (run-or-raise "conkeror" '(:class "Conkeror")))
(define-key *root-map* (kbd "b") "browser")

(defcommand terminal () ()
  "run or raise urxvt"
  (run-or-raise "urxvt -e tmux" '(:class "URxvt")))
(define-key *root-map* (kbd "c") "terminal")

;; (defcommand dropbox-status () ()
;;   (run-shell-command "dropbox status"))

;; (defcommand mode-line-toggle () ()
;;   "Toggles the mode-line"
;;   (toggle-mode-line (current-screen) (current-head)))
;; (define-key *top-map* (kbd "M-m") "mode-line-toggle")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (define-key *root-map* (kbd "o") "only")
;; (define-key *root-map* (kbd "z") "windows")

;; (define-key *root-map* (kbd "C-Up") "move-window up")
;; (define-key *root-map* (kbd "C-Left") "move-window left")
;; (define-key *root-map* (kbd "C-Down") "move-window down")
;; (define-key *root-map* (kbd "C-Right") "move-window right")

(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "C-z") "echo Zzzzz...")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (terminal)
;; (browser)
