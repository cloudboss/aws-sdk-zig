/// The target to which to send matching events.
pub const EventBridgeRuleTemplateTarget = struct {
    /// Target ARNs must be either an SNS topic or CloudWatch log group.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
