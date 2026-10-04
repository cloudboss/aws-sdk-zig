/// The configuration for an Amazon EventBridge hook target.
pub const HarnessHookEventBridgeTarget = struct {
    /// The ARN of the Amazon EventBridge event bus to send hook events to.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
