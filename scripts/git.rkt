#lang racket

;; git pull and push all my work


;; TODO return (exit-code, output)
(define (git-op repo op)
  (let ([cmd (case op
               [(pull) "git pull"]
               [(status) "git status"])])
    (parameterize ([current-directory (expand-user-path repo)])
      ;; (displayln (string-append "Processing " repo " ..."))
      (displayln
       (format "End: Process ~a, with output~n~a~n"
               repo
               (with-output-to-string
                 (lambda ()
                   (case (system cmd #:set-pwd? #t)
                     [(#t) (displayln (string-append "Succeeded " repo))]
                     [(#f) (displayln (string-append "Failed " repo))]))))))))

(define (git-pull repo)
  (git-op repo 'pull))
(define (git-status repo)
  (git-op repo 'status))


(define (join-threads threads)
  (displayln (format "Syncing on ~a threads .." (length threads)))
  (when (not (empty? threads))
    (let ([ready-thread (apply sync threads)])
      (join-threads (remove ready-thread threads)))))

(define (git-pull-repos repos)
  (join-threads (map (lambda (repo)
                       (thread (lambda ()
                                 (git-pull repo))))
                     repos)))
(define (git-status-repos repos)
  (join-threads (map (lambda (repo)
                       (thread (lambda ()
                                 (git-status repo))))
                     repos)))

(module+ test
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
  (git-pull-repos all-repos)
  (git-status-repos all-repos))

#;
(define (git-pull-all)
  (let loop ([threads ])
    (displayln "Syncing ..")
    (when (not (empty? threads))
      (let ([ready-thread (apply sync threads)])
        (displayln (format "# Finished one, ~a remaining" (- (length threads) 1)))
        (loop (remove ready-thread threads))))))
