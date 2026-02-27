/// Contains the ARN details about the IAM entity for which the policy is
/// generated.
pub const PolicyGenerationDetails = struct {
    /// The ARN of the IAM entity (user or role) for which you are generating a
    /// policy.
    principal_arn: []const u8,

    pub const json_field_names = .{
        .principal_arn = "principalArn",
    };
};
