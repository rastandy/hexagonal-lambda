"use strict";
const schemas = require("../schemas");

module.exports = schemas.define({
  type: "object",
  required: ["body"],
  properties: {
    body: {
      type: "object"
    }
  },
  example() {
    return {body: JSON.stringify({foo: "FOO", bar: "BAR"})};
  }
});
