#lang racket

(require rackunit)
(require racket/format)

;; download youtube music


;; cmd: youtube-dl --extract-audio --audio-format flac <url>


;; f should have the desired suffix, like .flac
;; if no suffix, the ".flac" is used
(define (youtube-dl-full url f)
  (let ([cmd (get-youtube-dl-cmd url f)])
    (when (not (file-exists? f))
      (make-parent-directory* f)
      (system cmd))))

(define (youtube-dl url name)
  (youtube-dl-full url (string-append "download/" name ".flac")))

;; (get-youtube-dl-cmd "https://youtube.com" "download/a.mp3")

(define (get-youtube-dl-cmd url f)
  (let* ([ext (or (path-get-extension f)
                  (raise-syntax-error
                   #f "file name must contain extension"))]
         [name (path-replace-extension f "")]
         [form (subbytes ext 1)]
         [output (path-replace-extension f ext)])
    (format
     (string-append
      "youtube-dl"
      " --audio-quality 0"
      ;; " --keep-video"
      " --extract-audio"
      " --audio-format ~a"
      " --output \"~a.%(ext)s\" ~a")
     form name url)))


(define (youtube-dl-multiple lst)
  (map (lambda (l) (apply youtube-dl l)) lst))


(define (str->sec str)
  (let* ([splits (string-split str ":")]
         [h (string->number (first splits))]
         [m (string->number (second splits))]
         [s (string->number (third splits))])
    (+ (* h 3600) (* m 60) s)))
(define (sec->str sec)
  (let ([s (modulo sec 60)]
        [m (modulo (quotient sec 60) 60)]
        [h (modulo (quotient sec 3600) 60)])
    (string-append (~a #:min-width 2 #:align 'right #:pad-string "0" h) ":"
                   (~a #:min-width 2 #:align 'right #:pad-string "0" m) ":"
                   (~a #:min-width 2 #:align 'right #:pad-string "0" s))))

(module+ test
  (check-equal? (str->sec "01:34:12") (+ 3600 (* 34 60) 12))
  (check-equal? (sec->str (+ 3600 (* 34 60) 12)) "01:34:12"))


(define (ffmpeg-part input start end output)
  (let* ([duration (sec->str (- (str->sec end) (str->sec start)))]
         [cmd (format
              "ffmpeg -y -ss ~a -i \"~a\" -t ~a \"~a\""
              start input duration output)])
    (display cmd)
    (system cmd)))

(define (ffmpeg-part-multiple input parts)
  (for ([part parts])
    (let ([start (first part)]
          [end (second part)]
          [name (third part)])
      (ffmpeg-part input start end
                   (string-append "download/" name ".flac")))))

(define (youtube-dl-parts url parts)
  ;; check if the files exists in download
  (if (for/and ([part parts])
        (file-exists? (string-append "download/" (third part) ".flac")))
      (println "All files exist. Do nothing.")
      ;; (println "actually need to do something")
      (when (youtube-dl-full url "tmp.flac")
        (println "====== Downloaded, running ffmpeg to split ..")
        (ffmpeg-part-multiple
         "tmp.flac" parts)
        (println "====== Deleting the file ..")
        (delete-file "tmp.flac"))))

(module+ test
  (youtube-dl-multiple
   '(("https://www.youtube.com/watch?v=s-CcFyyPJiY&index=2&list=RDvTtcFMY7-vI"
      "張杰 - 三生三世")
     ("https://www.youtube.com/watch?v=vTtcFMY7-vI&list=RDvTtcFMY7-vI&t=2"
      "杨宗纬&张碧晨 - 涼涼")
     ("https://www.youtube.com/watch?v=c68lZi7Kej8&list=RDvTtcFMY7-vI&index=3"
      "郁可唯 - 思慕")
     ("https://www.youtube.com/watch?v=QMi9DQPTIa8&list=RDvTtcFMY7-vI&index=4"
      "董貞 - 繁花")
     ("https://www.youtube.com/watch?v=9NIrgZwwOcY&list=PLfkWGvionty8hx8e6yz9gDbehWAccLVKb&index=3"
      "香香 - 就算沒有如果")))

  (youtube-dl-multiple
   '(("https://www.youtube.com/watch?v=JGwWNGJdvx8"
      "Ed Sheeran - Shape of You")
     ("https://www.youtube.com/watch?v=lp-EO5I60KA"
      "Ed Sheeran - Thinking Out Loud")
     ("https://www.youtube.com/watch?v=V54CEElTF_U"
      "Taylor Swift - Call It What You Want")
     ("https://www.youtube.com/watch?v=8xg3vE8Ie_E"
      "Taylor Swift - Love Story")
     ("https://www.youtube.com/watch?v=VuNIsY6JdUw"
      "Taylor Swift - You Belong With Me")
     ("https://www.youtube.com/watch?v=AJtDXIazrMo&index=10&list=RD8xg3vE8Ie_E"
      "Ellie Goulding - Love Me Like You Do")
     ("https://www.youtube.com/watch?v=Zlot0i3Zykw&index=11&list=RD8xg3vE8Ie_E"
      "Taylor Swift - Red")
     ("https://www.youtube.com/watch?v=AgFeZr5ptV8&list=RD8xg3vE8Ie_E&index=15"
      "Taylor Swift - 22")
     ("https://www.youtube.com/watch?v=xKCek6_dB0M&list=RD8xg3vE8Ie_E&index=16"
      "Taylor Swift - Teardrops On My Guitar")
     ("https://www.youtube.com/watch?v=nfWlot6h_JM&list=RD8xg3vE8Ie_E&index=23"
      "Taylor Swift - Shake It Off")
     ("https://www.youtube.com/watch?v=Bg59q4puhmg&list=RD8xg3vE8Ie_E&index=47"
      "Avril Lavigne - Girlfriend")
     ("https://www.youtube.com/watch?v=5NPBIwQyPWE"
      "Avril Lavigne - Complicated")
     ("https://www.youtube.com/watch?v=8xoG0Xv3vs0"
      "Avril Lavigne - Innocence")
     ("https://www.youtube.com/watch?v=P1qnhfb3PUY&list=RDGMEMQ1dJ7wXfLlqCjwV0xfSNbAVMP1qnhfb3PUY"
      "Taylor Swift - Blank Space")))

  ;; (youtube-dl-single "https://www.youtube.com/watch?v=5NPBIwQyPWE" "aaa" "mp3")
  (youtube-dl-multiple
   '(("https://www.youtube.com/watch?v=BsvIwqyiaJw&list=RDBsvIwqyiaJw"
      "李毓芬 - 是我不夠好")
     ("https://www.youtube.com/watch?v=enFGhIcD1d8"
      "告白氣球 - 周二珂")))
  (youtube-dl-parts "https://www.youtube.com/watch?v=MmKlaGpmYig"
                    '(("00:00:00" "00:03:49" "LaLaLand - Another Day Of Sun")
                      ("00:03:49" "00:08:08" "LaLaLand - Someone In The Crowd")
                      ("00:08:08" "00:09:47" "LaLaLand - Mia & Sebastian's Theme")
                      ("00:09:47" "00:13:42" "LaLaLand - A Lovely Night")
                      ("00:13:42" "00:15:48" "LaLaLand - Summer Montage")
                      ("00:15:48" "00:17:40" "LaLaLand - City of Stars")
                      ("00:17:40" "00:21:56" "LaLaLand - Planetarium")
                      ("00:21:56" "00:23:49" "LaLaLand - Herman's Habit")
                      ("00:23:49" "00:26:16" "LaLaLand - City Of Stars DUET")
                      ("00:26:16" "00:29:27" "LaLaLand - Start A Fire")
                      ("00:29:27" "00:30:53" "LaLaLand - Engagement Party")
                      ("00:30:53" "00:34:42" "LaLaLand - The Fools Who Dream")
                      ("00:34:42" "00:42:22" "LaLaLand - Epilogue")
                      ("00:42:22" "00:43:08" "LaLaLand - The End")
                      ("00:43:08" "00:45:52" "LaLaLand - City Of Stars")
                      ("00:45:52" "00:47:19" "LaLaLand - Mia And Sebastian's Theme"))))

