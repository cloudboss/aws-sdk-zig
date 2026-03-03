/// Optional IAM policy. The resulting job IAM role permissions will be an
/// intersection of the policies passed and the policy associated with your job
/// execution role.
pub const JobRunExecutionIamPolicy = struct {
    /// An IAM inline policy to use as an execution IAM policy.
    policy: ?[]const u8 = null,

    /// A list of Amazon Resource Names (ARNs) to use as an execution IAM policy.
    policy_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .policy = "policy",
        .policy_arns = "policyArns",
    };
};
