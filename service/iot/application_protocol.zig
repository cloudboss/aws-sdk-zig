pub const ApplicationProtocol = enum {
    secure_mqtt,
    mqtt_wss,
    https,
    default,

    pub const json_field_names = .{
        .secure_mqtt = "SECURE_MQTT",
        .mqtt_wss = "MQTT_WSS",
        .https = "HTTPS",
        .default = "DEFAULT",
    };
};
