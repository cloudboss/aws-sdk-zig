pub const ExpressionType = enum {
    rule_name,
    mqtt_topic,

    pub const json_field_names = .{
        .rule_name = "RuleName",
        .mqtt_topic = "MqttTopic",
    };
};
