#lang racket

;; git pull and push all my work

(define (git-op repo op)
  (let ([arg (case op
               [(pull) "pull"]
               [(status) "status"]
               [(push) "push"]
               [else (raise-syntax-error #f "unsupported git command" op)])])
    (parameterize ([current-directory (expand-user-path repo)])
      (let-values ([(sp stdout stdin _stderr)
                    (subprocess #f #f 'stdout (find-executable-path "git") arg)])
        ;; block
        (subprocess-wait sp)
        (let ([exit (subprocess-status sp)]
              [output (port->string stdout)])
          (close-output-port stdin)
          (close-input-port stdout)
          (values exit output))))))

;; (subprocess (current-output-port) #f (current-error-port) "/usr/bin/pwd")
;; (find-executable-path "echo")

(define (git-pull repo)
  (let-values ([(exit out) (git-op repo 'pull)])
    (cond
      [(not (zero? exit)) (display (format "fatal: ~a failed" repo))]
      [(string-contains? out "Already up to date") (displayln (format "~a: Up to date" repo))]
      [else (displayln (~a repo ": Pulled"))
            (displayln out)])))

(define (git-push repo)
  (let-values ([(exit out) (git-op repo 'push)])
    (cond
      [(not (zero? exit)) (display (format "fatal: ~a failed" repo))]
      [(string-contains? out "Everything up-to-date") (displayln (format "~a: Up to date" repo))]
      [else (displayln (~a repo ": Pushed"))
            (displayln out)])))

(define (git-status repo)
  (let-values ([(exit out) (git-op repo 'status)])
    (cond
      [(not (zero? exit)) (display (format "----- fatal: ~a failed" repo))]
      [(string-contains? out "Your branch is ahead of") (displayln (~a "------ " repo ": Local change not pushed"))
                                                        (displayln out)]
      [(string-contains? out "Changes not staged") (displayln (~a "------ " repo ": Changes not staged"))
                                                   (displayln out)]
      [(string-contains? out "Changes to be committed") (displayln (~a "------ " repo ": Changes to be committed"))
                                                        (displayln out)]
      [(string-contains? out "working tree clean") (displayln (format "~a: clean" repo))]
      [else (displayln (~a "------ " repo ": dirty"))
            (displayln out)])))

;; (git-pull "~/github/wiki")
;; (git-status "~/github/wiki")

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
(define (git-push-repos repos)
  (join-threads (map (lambda (repo)
                       (thread (lambda ()
                                 (git-push repo))))
                     repos)))
(define (git-status-repos repos)
  (join-threads (map (lambda (repo)
                       (thread (lambda ()
                                 (git-status repo))))
                     repos)))


(module+ test
  ;; TODO download missing repo
  (define all-repos '("~/github/wiki"
                      "~/github/homepage"
                      "~/github/bibliography"
                      "~/github/books"
                      "~/github/hebicc"
                      "~/github/helium"
                      "~/github/helium2"
                      "~/github/note"
                      "~/github/research"
                      ;; "~/github/research/pdf"
                      "~/github/papers"
                      ;; "~/github/scratch/"
                      "~/.hebi"
                      "~/.stumpwm.d"
                      "~/.emacs.d"
                      ))
  (git-pull-repos all-repos)
  (git-status-repos all-repos)
  (git-push-repos all-repos))

#;
(define (git-pull-all)
  (let loop ([threads ])
    (displayln "Syncing ..")
    (when (not (empty? threads))
      (let ([ready-thread (apply sync threads)])
        (displayln (format "# Finished one, ~a remaining" (- (length threads) 1)))
        (loop (remove ready-thread threads))))))
