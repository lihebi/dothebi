#lang racket

;; git pull and push all my work

(define (git-pull repo)
  (parameterize ([current-directory (expand-user-path repo)])
    (displayln (string-append "Pulling " repo " ..."))
    (case (system "git pull"
                  #:set-pwd? #t)
      [(#t) (displayln (string-append "Succeeded " repo))]
      [(#f) (displayln (string-append "Failed " repo))])))

(define all-repos '("~/github/wiki"
                    "~/github/bibliography"
                    "~/github/books"
                    "~/github/hebicc"
                    "~/github/helium"
                    "~/github/note"
                    "~/github/papers"
                    "~/github/scratch/"
                    "~/.hebi"
                    "~/.stumpwm.d"
                    "~/.emacs.d"
                    ))

(define (git-pull-all)
  (let loop ([threads (map (lambda (repo)
                             (thread (lambda ()
                                       (git-pull repo))))
                           all-repos)])
    (displayln "Syncing ..")
    (when (not (empty? threads))
      (let ([ready-thread (apply sync threads)])
        (displayln (format "# Finished one, ~a remaining" (- (length threads) 1)))
        (loop (remove ready-thread threads))))))
