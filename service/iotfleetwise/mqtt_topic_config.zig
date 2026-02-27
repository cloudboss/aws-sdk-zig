/// The MQTT topic to which the Amazon Web Services IoT FleetWise campaign
/// routes data. For more information, see [Device communication
/// protocols](https://docs.aws.amazon.com/iot/latest/developerguide/protocols.html) in the *Amazon Web Services IoT Core Developer Guide*.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const MqttTopicConfig = struct {
    /// The ARN of the role that grants Amazon Web Services IoT FleetWise permission
    /// to access and act on messages sent to
    /// the MQTT topic.
    execution_role_arn: []const u8,

    /// The ARN of the MQTT topic.
    mqtt_topic_arn: []const u8,

    pub const json_field_names = .{
        .execution_role_arn = "executionRoleArn",
        .mqtt_topic_arn = "mqttTopicArn",
    };
};
