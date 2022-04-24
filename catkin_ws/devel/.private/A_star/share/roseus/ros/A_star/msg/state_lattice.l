;; Auto-generated. Do not edit!


(when (boundp 'A_star::state_lattice)
  (if (not (find-package "A_STAR"))
    (make-package "A_STAR"))
  (shadow 'state_lattice (find-package "A_STAR")))
(unless (find-package "A_STAR::STATE_LATTICE")
  (make-package "A_STAR::STATE_LATTICE"))

(in-package "ROS")
;;//! \htmlinclude state_lattice.msg.html


(defclass A_star::state_lattice
  :super ros::object
  :slots (_state_lattice ))

(defmethod A_star::state_lattice
  (:init
   (&key
    ((:state_lattice __state_lattice) ())
    )
   (send-super :init)
   (setq _state_lattice __state_lattice)
   self)
  (:state_lattice
   (&rest __state_lattice)
   (if (keywordp (car __state_lattice))
       (send* _state_lattice __state_lattice)
     (progn
       (if __state_lattice (setq _state_lattice (car __state_lattice)))
       _state_lattice)))
  (:serialization-length
   ()
   (+
    ;; A_star/trajectory_info[] _state_lattice
    (apply #'+ (send-all _state_lattice :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; A_star/trajectory_info[] _state_lattice
     (write-long (length _state_lattice) s)
     (dolist (elem _state_lattice)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; A_star/trajectory_info[] _state_lattice
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _state_lattice (let (r) (dotimes (i n) (push (instance A_star::trajectory_info :init) r)) r))
     (dolist (elem- _state_lattice)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get A_star::state_lattice :md5sum-) "21d5c82c027bad3bde19fcd10f49336b")
(setf (get A_star::state_lattice :datatype-) "A_star/state_lattice")
(setf (get A_star::state_lattice :definition-)
      "A_star/trajectory_info[] state_lattice
================================================================================
MSG: A_star/trajectory_info
float64[] inputs
float64 max_F_xr
float64 max_F_xf
float64 max_F_yr
float64 max_F_yf
float64 t_execution
float64 dx
float64 dy
float64 du
")



(provide :A_star/state_lattice "21d5c82c027bad3bde19fcd10f49336b")


