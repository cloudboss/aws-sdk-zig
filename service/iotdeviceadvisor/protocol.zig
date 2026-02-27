pub const Protocol = enum {
    mqtt_v3_1_1,
    mqtt_v5,
    mqtt_v3_1_1_over_web_socket,
    mqtt_v5_over_web_socket,

    pub const json_field_names = .{
        .mqtt_v3_1_1 = "MqttV3_1_1",
        .mqtt_v5 = "MqttV5",
        .mqtt_v3_1_1_over_web_socket = "MqttV3_1_1_OverWebSocket",
        .mqtt_v5_over_web_socket = "MqttV5_OverWebSocket",
    };
};
