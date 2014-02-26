(add-to-list 'load-path "~/.emacs.d/cedet-1.1/common")
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

(setq initial-major-mode 'text-mode)
(setq user-full-name "Youlong Cheng")
(setq user-mail-address "youlongcheng@gmail.com")

(setq default-directory "~/") 

;;显示列号
(setq column-number-mode t)

;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(setq-default kill-whole-line t)

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-selection-value)

;; 自动的在文件末增加一新行
(setq require-final-newline t)

;; get rid of yes-or-no questions - y or n is enough
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key ( kbd "C-o") 'forward-word)
(global-set-key ( kbd "C-i") 'backward-word)
;;目的是开一个shell的小buffer，用于更方便地测试程序(也就是运行程序了)，我经常会用到。
;;f8就是另开一个buffer然后打开shell，C-f8则是在当前的buffer打开shell,shift+f8清空eshell
(defun swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this))
     (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
	(select-window other)
    )
)

(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-horizontally)
  (eshell)
  (swap-buffers-in-windows)
)

(defun my-eshell-clear-buffer ()
  "Eshell clear buffer."
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))

(global-set-key [(f8)] 'open-eshell-other-buffer)
(global-set-key [C-f8] 'eshell)
(global-set-key [S-f8] 'my-eshell-clear-buffer)


(global-set-key [C-z] 'undo)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key [f3] 'kill-this-buffer)
(global-set-key (kbd "M-<SPC>") 'set-mark-command)

 (defun sfp-page-down (&optional arg)
   (interactive "^P")
   (setq this-command 'next-line)
   (next-line
	(- (window-text-height)
	   next-screen-context-lines)))
(put 'sfp-page-down 'isearch-scroll t)
(put 'sfp-page-down 'CUA 'move)
    
(defun sfp-page-up (&optional arg)
  (interactive "^P")
  (setq this-command 'previous-line)
  (previous-line
   (- (window-text-height)
	  next-screen-context-lines)))
(put 'sfp-page-up 'isearch-scroll t)
(put 'sfp-page-up 'CUA 'move)

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height)))

(defun move-to-window-line-middle ()
  (interactive)
  (let* ((wb-height (window-buffer-height (get-buffer-window)))
        (actual-height (if (> wb-height (window-height))
                           (window-height)
                         wb-height)))
    (move-to-window-line (/ actual-height 2))))

(defun move_or_scroll_half()
  "when cursor locate in top half window, this function will move cursor to middle of window,if cursor is in bottom half window, this function will scroll forward half of window"
  (interactive)
  (setq n (line-number-at-pos))
  (setq halflen (/ (count-lines (window-start) (window-end) ) 2))
  (setq top_window_line (count-lines (window-start) (point-min) ))
  (setq middleline (+ top_window_line halflen))
  ;(message "n: %d halflen: %d middleline: %d" n halflen middleline)
  (if (< n middleline)
		(move-to-window-line-middle)
	  (scroll-up-half)))
  
(global-set-key (kbd "C-u") 'sfp-page-up)
(global-set-key (kbd "C-j") 'move_or_scroll_half)

<<<<<<< HEAD
=======
(global-linum-mode t)
>>>>>>> 78e2ee83e9d77c5258a66c0c6a18ee3b3431d65e

(provide 'init-local)

