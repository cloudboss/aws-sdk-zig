const SamplingRule = @import("sampling_rule.zig").SamplingRule;

/// A
/// [SamplingRule](https://docs.aws.amazon.com/xray/latest/api/API_SamplingRule.html) and its metadata.
pub const SamplingRuleRecord = struct {
    /// When the rule was created.
    created_at: ?i64 = null,

    /// When the rule was last modified.
    modified_at: ?i64 = null,

    /// The sampling rule.
    sampling_rule: ?SamplingRule = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .modified_at = "ModifiedAt",
        .sampling_rule = "SamplingRule",
    };
};
