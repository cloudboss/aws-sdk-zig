/// Includes information about tags you define to assign tagged resources to a
/// backup
/// plan.
///
/// Include the prefix `aws:ResourceTag` in your tags.
/// For example, `"aws:ResourceTag/TagKey1": "Value1"`.
pub const ConditionParameter = struct {
    /// The key in a key-value pair. For example, in the tag `Department:
    /// Accounting`, `Department` is the key.
    condition_key: ?[]const u8 = null,

    /// The value in a key-value pair. For example, in the tag `Department:
    /// Accounting`, `Accounting` is the value.
    condition_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .condition_key = "ConditionKey",
        .condition_value = "ConditionValue",
    };
};
