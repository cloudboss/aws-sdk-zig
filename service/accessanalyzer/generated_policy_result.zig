const GeneratedPolicy = @import("generated_policy.zig").GeneratedPolicy;
const GeneratedPolicyProperties = @import("generated_policy_properties.zig").GeneratedPolicyProperties;

/// Contains the text for the generated policy and its details.
pub const GeneratedPolicyResult = struct {
    /// The text to use as the content for the new policy. The policy is created
    /// using the
    /// [CreatePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicy.html) action.
    generated_policies: ?[]const GeneratedPolicy = null,

    /// A `GeneratedPolicyProperties` object that contains properties of the
    /// generated policy.
    properties: GeneratedPolicyProperties,

    pub const json_field_names = .{
        .generated_policies = "generatedPolicies",
        .properties = "properties",
    };
};
