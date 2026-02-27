const Payload = @import("payload.zig").Payload;

/// Information required to publish the Amazon SNS message.
pub const SNSTopicPublishAction = struct {
    /// You can configure the action payload when you send a message as an Amazon
    /// SNS push
    /// notification.
    payload: ?Payload,

    /// The ARN of the Amazon SNS target where the message is sent.
    target_arn: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .target_arn = "targetArn",
    };
};
