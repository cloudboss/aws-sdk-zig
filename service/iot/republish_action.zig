const MqttHeaders = @import("mqtt_headers.zig").MqttHeaders;

/// Describes an action to republish to another topic.
pub const RepublishAction = struct {
    /// MQTT Version 5.0 headers information. For more information, see [
    /// MQTT](https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html) from
    /// the Amazon Web Services IoT Core Developer Guide.
    headers: ?MqttHeaders,

    /// The Quality of Service (QoS) level to use when republishing messages. The
    /// default value
    /// is 0.
    qos: ?i32,

    /// The ARN of the IAM role that grants access.
    role_arn: []const u8,

    /// The name of the MQTT topic.
    topic: []const u8,

    pub const json_field_names = .{
        .headers = "headers",
        .qos = "qos",
        .role_arn = "roleArn",
        .topic = "topic",
    };
};
