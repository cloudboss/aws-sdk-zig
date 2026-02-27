const ConditionType = @import("condition_type.zig").ConditionType;

/// Contains an array of triplets made up of a condition type (such as
/// `StringEquals`), a key, and a value. Used to filter resources using their
/// tags and assign them to a backup plan. Case sensitive.
pub const Condition = struct {
    /// The key in a key-value pair. For example, in the tag `Department:
    /// Accounting`, `Department` is the key.
    condition_key: []const u8,

    /// An operation applied to a key-value pair used to assign resources to your
    /// backup plan.
    /// Condition only supports `StringEquals`. For more flexible assignment
    /// options,
    /// including `StringLike` and the ability to exclude resources from your backup
    /// plan, use `Conditions` (with an "s" on the end) for your [
    /// `BackupSelection`
    /// ](https://docs.aws.amazon.com/aws-backup/latest/devguide/API_BackupSelection.html).
    condition_type: ConditionType,

    /// The value in a key-value pair. For example, in the tag `Department:
    /// Accounting`, `Accounting` is the value.
    condition_value: []const u8,

    pub const json_field_names = .{
        .condition_key = "ConditionKey",
        .condition_type = "ConditionType",
        .condition_value = "ConditionValue",
    };
};
