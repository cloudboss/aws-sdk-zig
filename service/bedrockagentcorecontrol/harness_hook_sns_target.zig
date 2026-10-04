/// The configuration for an Amazon SNS hook target.
pub const HarnessHookSnsTarget = struct {
    /// The ARN of the Amazon SNS topic to publish hook events to.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
