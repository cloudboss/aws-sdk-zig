const Payload = @import("payload.zig").Payload;

/// Information required to publish the MQTT message through the AWS IoT message
/// broker.
pub const IotTopicPublishAction = struct {
    /// The MQTT topic of the message. You can use a string expression that includes
    /// variables
    /// (`$variable.`) and input values
    /// (`$input..`) as the topic string.
    mqtt_topic: []const u8,

    /// You can configure the action payload when you publish a message to an AWS
    /// IoT Core
    /// topic.
    payload: ?Payload,

    pub const json_field_names = .{
        .mqtt_topic = "mqttTopic",
        .payload = "payload",
    };
};
