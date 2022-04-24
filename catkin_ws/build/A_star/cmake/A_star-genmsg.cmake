# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "A_star: 2 messages, 0 services")

set(MSG_I_FLAGS "-IA_star:/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-IA_star:/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(A_star_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_custom_target(_A_star_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "A_star" "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" ""
)

get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_custom_target(_A_star_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "A_star" "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" "A_star/trajectory_info"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/A_star
)
_generate_msg_cpp(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg"
  "${MSG_I_FLAGS}"
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/A_star
)

### Generating Services

### Generating Module File
_generate_module_cpp(A_star
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/A_star
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(A_star_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(A_star_generate_messages A_star_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_dependencies(A_star_generate_messages_cpp _A_star_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_dependencies(A_star_generate_messages_cpp _A_star_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(A_star_gencpp)
add_dependencies(A_star_gencpp A_star_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS A_star_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/A_star
)
_generate_msg_eus(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg"
  "${MSG_I_FLAGS}"
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/A_star
)

### Generating Services

### Generating Module File
_generate_module_eus(A_star
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/A_star
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(A_star_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(A_star_generate_messages A_star_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_dependencies(A_star_generate_messages_eus _A_star_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_dependencies(A_star_generate_messages_eus _A_star_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(A_star_geneus)
add_dependencies(A_star_geneus A_star_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS A_star_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/A_star
)
_generate_msg_lisp(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg"
  "${MSG_I_FLAGS}"
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/A_star
)

### Generating Services

### Generating Module File
_generate_module_lisp(A_star
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/A_star
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(A_star_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(A_star_generate_messages A_star_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_dependencies(A_star_generate_messages_lisp _A_star_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_dependencies(A_star_generate_messages_lisp _A_star_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(A_star_genlisp)
add_dependencies(A_star_genlisp A_star_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS A_star_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/A_star
)
_generate_msg_nodejs(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg"
  "${MSG_I_FLAGS}"
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/A_star
)

### Generating Services

### Generating Module File
_generate_module_nodejs(A_star
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/A_star
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(A_star_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(A_star_generate_messages A_star_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_dependencies(A_star_generate_messages_nodejs _A_star_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_dependencies(A_star_generate_messages_nodejs _A_star_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(A_star_gennodejs)
add_dependencies(A_star_gennodejs A_star_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS A_star_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star
)
_generate_msg_py(A_star
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg"
  "${MSG_I_FLAGS}"
  "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star
)

### Generating Services

### Generating Module File
_generate_module_py(A_star
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(A_star_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(A_star_generate_messages A_star_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/trajectory_info.msg" NAME_WE)
add_dependencies(A_star_generate_messages_py _A_star_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hansen/Desktop/Motion_Planning_Project/catkin_ws/src/A_star/msg/state_lattice.msg" NAME_WE)
add_dependencies(A_star_generate_messages_py _A_star_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(A_star_genpy)
add_dependencies(A_star_genpy A_star_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS A_star_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/A_star)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/A_star
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(A_star_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET A_star_generate_messages_cpp)
  add_dependencies(A_star_generate_messages_cpp A_star_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/A_star)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/A_star
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(A_star_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET A_star_generate_messages_eus)
  add_dependencies(A_star_generate_messages_eus A_star_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/A_star)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/A_star
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(A_star_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET A_star_generate_messages_lisp)
  add_dependencies(A_star_generate_messages_lisp A_star_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/A_star)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/A_star
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(A_star_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET A_star_generate_messages_nodejs)
  add_dependencies(A_star_generate_messages_nodejs A_star_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/A_star
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(A_star_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET A_star_generate_messages_py)
  add_dependencies(A_star_generate_messages_py A_star_generate_messages_py)
endif()
