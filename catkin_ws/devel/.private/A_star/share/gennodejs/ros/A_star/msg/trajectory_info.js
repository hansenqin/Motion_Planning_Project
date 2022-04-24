// Auto-generated. Do not edit!

// (in-package A_star.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class trajectory_info {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.inputs = null;
      this.max_F_xr = null;
      this.max_F_xf = null;
      this.max_F_yr = null;
      this.max_F_yf = null;
      this.t_execution = null;
      this.dx = null;
      this.dy = null;
      this.du = null;
    }
    else {
      if (initObj.hasOwnProperty('inputs')) {
        this.inputs = initObj.inputs
      }
      else {
        this.inputs = [];
      }
      if (initObj.hasOwnProperty('max_F_xr')) {
        this.max_F_xr = initObj.max_F_xr
      }
      else {
        this.max_F_xr = 0.0;
      }
      if (initObj.hasOwnProperty('max_F_xf')) {
        this.max_F_xf = initObj.max_F_xf
      }
      else {
        this.max_F_xf = 0.0;
      }
      if (initObj.hasOwnProperty('max_F_yr')) {
        this.max_F_yr = initObj.max_F_yr
      }
      else {
        this.max_F_yr = 0.0;
      }
      if (initObj.hasOwnProperty('max_F_yf')) {
        this.max_F_yf = initObj.max_F_yf
      }
      else {
        this.max_F_yf = 0.0;
      }
      if (initObj.hasOwnProperty('t_execution')) {
        this.t_execution = initObj.t_execution
      }
      else {
        this.t_execution = 0.0;
      }
      if (initObj.hasOwnProperty('dx')) {
        this.dx = initObj.dx
      }
      else {
        this.dx = 0.0;
      }
      if (initObj.hasOwnProperty('dy')) {
        this.dy = initObj.dy
      }
      else {
        this.dy = 0.0;
      }
      if (initObj.hasOwnProperty('du')) {
        this.du = initObj.du
      }
      else {
        this.du = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type trajectory_info
    // Serialize message field [inputs]
    bufferOffset = _arraySerializer.float64(obj.inputs, buffer, bufferOffset, null);
    // Serialize message field [max_F_xr]
    bufferOffset = _serializer.float64(obj.max_F_xr, buffer, bufferOffset);
    // Serialize message field [max_F_xf]
    bufferOffset = _serializer.float64(obj.max_F_xf, buffer, bufferOffset);
    // Serialize message field [max_F_yr]
    bufferOffset = _serializer.float64(obj.max_F_yr, buffer, bufferOffset);
    // Serialize message field [max_F_yf]
    bufferOffset = _serializer.float64(obj.max_F_yf, buffer, bufferOffset);
    // Serialize message field [t_execution]
    bufferOffset = _serializer.float64(obj.t_execution, buffer, bufferOffset);
    // Serialize message field [dx]
    bufferOffset = _serializer.float64(obj.dx, buffer, bufferOffset);
    // Serialize message field [dy]
    bufferOffset = _serializer.float64(obj.dy, buffer, bufferOffset);
    // Serialize message field [du]
    bufferOffset = _serializer.float64(obj.du, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type trajectory_info
    let len;
    let data = new trajectory_info(null);
    // Deserialize message field [inputs]
    data.inputs = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [max_F_xr]
    data.max_F_xr = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_F_xf]
    data.max_F_xf = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_F_yr]
    data.max_F_yr = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_F_yf]
    data.max_F_yf = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [t_execution]
    data.t_execution = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [dx]
    data.dx = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [dy]
    data.dy = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [du]
    data.du = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.inputs.length;
    return length + 68;
  }

  static datatype() {
    // Returns string type for a message object
    return 'A_star/trajectory_info';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3a80521809d1ba9b34b717fcd10c259f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] inputs
    float64 max_F_xr
    float64 max_F_xf
    float64 max_F_yr
    float64 max_F_yf
    float64 t_execution
    float64 dx
    float64 dy
    float64 du
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new trajectory_info(null);
    if (msg.inputs !== undefined) {
      resolved.inputs = msg.inputs;
    }
    else {
      resolved.inputs = []
    }

    if (msg.max_F_xr !== undefined) {
      resolved.max_F_xr = msg.max_F_xr;
    }
    else {
      resolved.max_F_xr = 0.0
    }

    if (msg.max_F_xf !== undefined) {
      resolved.max_F_xf = msg.max_F_xf;
    }
    else {
      resolved.max_F_xf = 0.0
    }

    if (msg.max_F_yr !== undefined) {
      resolved.max_F_yr = msg.max_F_yr;
    }
    else {
      resolved.max_F_yr = 0.0
    }

    if (msg.max_F_yf !== undefined) {
      resolved.max_F_yf = msg.max_F_yf;
    }
    else {
      resolved.max_F_yf = 0.0
    }

    if (msg.t_execution !== undefined) {
      resolved.t_execution = msg.t_execution;
    }
    else {
      resolved.t_execution = 0.0
    }

    if (msg.dx !== undefined) {
      resolved.dx = msg.dx;
    }
    else {
      resolved.dx = 0.0
    }

    if (msg.dy !== undefined) {
      resolved.dy = msg.dy;
    }
    else {
      resolved.dy = 0.0
    }

    if (msg.du !== undefined) {
      resolved.du = msg.du;
    }
    else {
      resolved.du = 0.0
    }

    return resolved;
    }
};

module.exports = trajectory_info;
