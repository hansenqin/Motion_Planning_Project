;; Auto-generated. Do not edit!


(when (boundp 'A_star::trajectory_info)
  (if (not (find-package "A_STAR"))
    (make-package "A_STAR"))
  (shadow 'trajectory_info (find-package "A_STAR")))
(unless (find-package "A_STAR::TRAJECTORY_INFO")
  (make-package "A_STAR::TRAJECTORY_INFO"))

(in-package "ROS")
;;//! \htmlinclude trajectory_info.msg.html


(defclass A_star::trajectory_info
  :super ros::object
  :slots (_inputs _max_F_xr _max_F_xf _max_F_yr _max_F_yf _t_execution _dx _dy _du ))

(defmethod A_star::trajectory_info
  (:init
   (&key
    ((:inputs __inputs) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:max_F_xr __max_F_xr) 0.0)
    ((:max_F_xf __max_F_xf) 0.0)
    ((:max_F_yr __max_F_yr) 0.0)
    ((:max_F_yf __max_F_yf) 0.0)
    ((:t_execution __t_execution) 0.0)
    ((:dx __dx) 0.0)
    ((:dy __dy) 0.0)
    ((:du __du) 0.0)
    )
   (send-super :init)
   (setq _inputs __inputs)
   (setq _max_F_xr (float __max_F_xr))
   (setq _max_F_xf (float __max_F_xf))
   (setq _max_F_yr (float __max_F_yr))
   (setq _max_F_yf (float __max_F_yf))
   (setq _t_execution (float __t_execution))
   (setq _dx (float __dx))
   (setq _dy (float __dy))
   (setq _du (float __du))
   self)
  (:inputs
   (&optional __inputs)
   (if __inputs (setq _inputs __inputs)) _inputs)
  (:max_F_xr
   (&optional __max_F_xr)
   (if __max_F_xr (setq _max_F_xr __max_F_xr)) _max_F_xr)
  (:max_F_xf
   (&optional __max_F_xf)
   (if __max_F_xf (setq _max_F_xf __max_F_xf)) _max_F_xf)
  (:max_F_yr
   (&optional __max_F_yr)
   (if __max_F_yr (setq _max_F_yr __max_F_yr)) _max_F_yr)
  (:max_F_yf
   (&optional __max_F_yf)
   (if __max_F_yf (setq _max_F_yf __max_F_yf)) _max_F_yf)
  (:t_execution
   (&optional __t_execution)
   (if __t_execution (setq _t_execution __t_execution)) _t_execution)
  (:dx
   (&optional __dx)
   (if __dx (setq _dx __dx)) _dx)
  (:dy
   (&optional __dy)
   (if __dy (setq _dy __dy)) _dy)
  (:du
   (&optional __du)
   (if __du (setq _du __du)) _du)
  (:serialization-length
   ()
   (+
    ;; float64[] _inputs
    (* 8    (length _inputs)) 4
    ;; float64 _max_F_xr
    8
    ;; float64 _max_F_xf
    8
    ;; float64 _max_F_yr
    8
    ;; float64 _max_F_yf
    8
    ;; float64 _t_execution
    8
    ;; float64 _dx
    8
    ;; float64 _dy
    8
    ;; float64 _du
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _inputs
     (write-long (length _inputs) s)
     (dotimes (i (length _inputs))
       (sys::poke (elt _inputs i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64 _max_F_xr
       (sys::poke _max_F_xr (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _max_F_xf
       (sys::poke _max_F_xf (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _max_F_yr
       (sys::poke _max_F_yr (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _max_F_yf
       (sys::poke _max_F_yf (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _t_execution
       (sys::poke _t_execution (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _dx
       (sys::poke _dx (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _dy
       (sys::poke _dy (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _du
       (sys::poke _du (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _inputs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _inputs (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _inputs i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64 _max_F_xr
     (setq _max_F_xr (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _max_F_xf
     (setq _max_F_xf (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _max_F_yr
     (setq _max_F_yr (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _max_F_yf
     (setq _max_F_yf (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _t_execution
     (setq _t_execution (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _dx
     (setq _dx (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _dy
     (setq _dy (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _du
     (setq _du (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get A_star::trajectory_info :md5sum-) "3a80521809d1ba9b34b717fcd10c259f")
(setf (get A_star::trajectory_info :datatype-) "A_star/trajectory_info")
(setf (get A_star::trajectory_info :definition-)
      "float64[] inputs
float64 max_F_xr
float64 max_F_xf
float64 max_F_yr
float64 max_F_yf
float64 t_execution
float64 dx
float64 dy
float64 du
")



(provide :A_star/trajectory_info "3a80521809d1ba9b34b717fcd10c259f")


