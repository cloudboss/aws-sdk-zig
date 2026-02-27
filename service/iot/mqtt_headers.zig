const UserProperty = @import("user_property.zig").UserProperty;

/// Specifies MQTT Version 5.0 headers information. For more information, see [
/// MQTT](https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html) from
/// Amazon Web Services IoT Core Developer Guide.
pub const MqttHeaders = struct {
    /// A UTF-8 encoded string that describes the content of the publishing message.
    ///
    /// For more information, see [
    /// Content
    /// Type](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901118) from the MQTT Version 5.0 specification.
    ///
    /// Supports [substitution
    /// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
    content_type: ?[]const u8,

    /// The base64-encoded binary data used by the sender of the request message to
    /// identify which request the response message is
    /// for when it's received.
    ///
    /// For more information, see [
    /// Correlation
    /// Data](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901115) from the MQTT Version 5.0 specification.
    ///
    /// This binary data must be based64-encoded.
    ///
    /// Supports [substitution
    /// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
    correlation_data: ?[]const u8,

    /// A user-defined integer value that will persist a message at the message
    /// broker for a
    /// specified amount of time to ensure that the message will expire if it's no
    /// longer relevant to
    /// the subscriber. The value of `messageExpiry` represents the number of
    /// seconds
    /// before it expires. For more information about the limits of `messageExpiry`,
    /// see [Amazon Web Services IoT Core message broker and protocol
    /// limits and quotas
    /// ](https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html) from the
    /// Amazon Web Services Reference Guide.
    ///
    /// Supports [substitution
    /// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
    message_expiry: ?[]const u8,

    /// An `Enum` string value that indicates whether the payload is formatted as
    /// UTF-8.
    ///
    /// Valid values are `UNSPECIFIED_BYTES` and `UTF8_DATA`.
    ///
    /// For more information, see [
    /// Payload Format
    /// Indicator](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901111) from the MQTT Version 5.0 specification.
    ///
    /// Supports [substitution
    /// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
    payload_format_indicator: ?[]const u8,

    /// A UTF-8 encoded string that's used as the topic name for a response message.
    /// The response topic is used to describe
    /// the topic which the receiver should publish to as part of the
    /// request-response flow. The topic must not contain wildcard
    /// characters.
    ///
    /// For more information, see [
    /// Response
    /// Topic](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901114) from the MQTT Version 5.0 specification.
    ///
    /// Supports [substitution
    /// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
    response_topic: ?[]const u8,

    /// An array of key-value pairs that you define in the MQTT5 header.
    user_properties: ?[]const UserProperty,

    pub const json_field_names = .{
        .content_type = "contentType",
        .correlation_data = "correlationData",
        .message_expiry = "messageExpiry",
        .payload_format_indicator = "payloadFormatIndicator",
        .response_topic = "responseTopic",
        .user_properties = "userProperties",
    };
};
