pub const DeleteRuleRequest = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .rule_id = "RuleId",
    };
};
