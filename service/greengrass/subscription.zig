/// Information about a subscription.
pub const Subscription = struct {
    /// A descriptive or arbitrary ID for the subscription. This value must be
    /// unique within the subscription definition version. Max length is 128
    /// characters with pattern ''[a-zA-Z0-9:_-]+''.
    id: []const u8,

    /// The source of the subscription. Can be a thing ARN, a Lambda function ARN, a
    /// connector ARN, 'cloud' (which represents the AWS IoT cloud), or
    /// 'GGShadowService'.
    source: []const u8,

    /// The MQTT topic used to route the message.
    subject: []const u8,

    /// Where the message is sent to. Can be a thing ARN, a Lambda function ARN, a
    /// connector ARN, 'cloud' (which represents the AWS IoT cloud), or
    /// 'GGShadowService'.
    target: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .source = "Source",
        .subject = "Subject",
        .target = "Target",
    };
};
