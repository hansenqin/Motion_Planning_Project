// Auto-generated. Do not edit!

// (in-package A_star.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let trajectory_info = require('./trajectory_info.js');

//-----------------------------------------------------------

class state_lattice {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.state_lattice = null;
    }
    else {
      if (initObj.hasOwnProperty('state_lattice')) {
        this.state_lattice = initObj.state_lattice
      }
      else {
        this.state_lattice = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type state_lattice
    // Serialize message field [state_lattice]
    // Serialize the length for message field [state_lattice]
    bufferOffset = _serializer.uint32(obj.state_lattice.length, buffer, bufferOffset);
    obj.state_lattice.forEach((val) => {
      bufferOffset = trajectory_info.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type state_lattice
    let len;
    let data = new state_lattice(null);
    // Deserialize message field [state_lattice]
    // Deserialize array length for message field [state_lattice]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.state_lattice = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.state_lattice[i] = trajectory_info.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.state_lattice.forEach((val) => {
      length += trajectory_info.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'A_star/state_lattice';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '21d5c82c027bad3bde19fcd10f49336b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    A_star/trajectory_info[] state_lattice
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new state_lattice(null);
    if (msg.state_lattice !== undefined) {
      resolved.state_lattice = new Array(msg.state_lattice.length);
      for (let i = 0; i < resolved.state_lattice.length; ++i) {
        resolved.state_lattice[i] = trajectory_info.Resolve(msg.state_lattice[i]);
      }
    }
    else {
      resolved.state_lattice = []
    }

    return resolved;
    }
};

module.exports = state_lattice;
