#!/usr/bin/env node
"use strict";
const {handler} = require("./lambda");
const eventSchema = require("./event-schema");

const event = eventSchema.example();
handler(event, {}, console.log);
