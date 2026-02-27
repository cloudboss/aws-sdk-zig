/// Set configurations for metrics export.
pub const MetricsExportConfig = struct {
    /// The MQTT topic that Device Defender Detect should publish messages to for
    /// metrics
    /// export.
    mqtt_topic: []const u8,

    /// This role ARN has permission to publish MQTT messages, after which Device
    /// Defender Detect
    /// can assume the role and publish messages on your behalf.
    role_arn: []const u8,

    pub const json_field_names = .{
        .mqtt_topic = "mqttTopic",
        .role_arn = "roleArn",
    };
};
