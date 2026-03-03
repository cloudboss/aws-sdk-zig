/// The policy that has the effect on the authorization results.
pub const EffectivePolicy = struct {
    /// The policy ARN.
    policy_arn: ?[]const u8 = null,

    /// The IAM policy document.
    policy_document: ?[]const u8 = null,

    /// The policy name.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
    };
};
