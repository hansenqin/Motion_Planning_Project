; Auto-generated. Do not edit!


(cl:in-package A_star-msg)


;//! \htmlinclude state_lattice.msg.html

(cl:defclass <state_lattice> (roslisp-msg-protocol:ros-message)
  ((state_lattice
    :reader state_lattice
    :initarg :state_lattice
    :type (cl:vector A_star-msg:trajectory_info)
   :initform (cl:make-array 0 :element-type 'A_star-msg:trajectory_info :initial-element (cl:make-instance 'A_star-msg:trajectory_info))))
)

(cl:defclass state_lattice (<state_lattice>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <state_lattice>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'state_lattice)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name A_star-msg:<state_lattice> is deprecated: use A_star-msg:state_lattice instead.")))

(cl:ensure-generic-function 'state_lattice-val :lambda-list '(m))
(cl:defmethod state_lattice-val ((m <state_lattice>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader A_star-msg:state_lattice-val is deprecated.  Use A_star-msg:state_lattice instead.")
  (state_lattice m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <state_lattice>) ostream)
  "Serializes a message object of type '<state_lattice>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'state_lattice))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'state_lattice))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <state_lattice>) istream)
  "Deserializes a message object of type '<state_lattice>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'state_lattice) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'state_lattice)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'A_star-msg:trajectory_info))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<state_lattice>)))
  "Returns string type for a message object of type '<state_lattice>"
  "A_star/state_lattice")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'state_lattice)))
  "Returns string type for a message object of type 'state_lattice"
  "A_star/state_lattice")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<state_lattice>)))
  "Returns md5sum for a message object of type '<state_lattice>"
  "21d5c82c027bad3bde19fcd10f49336b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'state_lattice)))
  "Returns md5sum for a message object of type 'state_lattice"
  "21d5c82c027bad3bde19fcd10f49336b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<state_lattice>)))
  "Returns full string definition for message of type '<state_lattice>"
  (cl:format cl:nil "A_star/trajectory_info[] state_lattice~%================================================================================~%MSG: A_star/trajectory_info~%float64[] inputs~%float64 max_F_xr~%float64 max_F_xf~%float64 max_F_yr~%float64 max_F_yf~%float64 t_execution~%float64 dx~%float64 dy~%float64 du~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'state_lattice)))
  "Returns full string definition for message of type 'state_lattice"
  (cl:format cl:nil "A_star/trajectory_info[] state_lattice~%================================================================================~%MSG: A_star/trajectory_info~%float64[] inputs~%float64 max_F_xr~%float64 max_F_xf~%float64 max_F_yr~%float64 max_F_yf~%float64 t_execution~%float64 dx~%float64 dy~%float64 du~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <state_lattice>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'state_lattice) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <state_lattice>))
  "Converts a ROS message object to a list"
  (cl:list 'state_lattice
    (cl:cons ':state_lattice (state_lattice msg))
))
