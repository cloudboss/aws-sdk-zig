/// Contains the text for the generated policy.
pub const GeneratedPolicy = struct {
    /// The text to use as the content for the new policy. The policy is created
    /// using the
    /// [CreatePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicy.html) action.
    policy: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
    };
};
