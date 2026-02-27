const PermissionConditionOperator = @import("permission_condition_operator.zig").PermissionConditionOperator;

/// Defines a condition that restricts when a permission is effective.
/// Conditions allow you to control access based on specific attributes of the
/// request.
pub const PermissionCondition = struct {
    /// The key for the condition. This identifies the attribute that the condition
    /// applies to.
    condition_key: []const u8,

    /// The operator to use for the condition evaluation. This determines how the
    /// condition values are compared.
    condition_operator: PermissionConditionOperator,

    /// The values to compare against using the specified condition operator.
    condition_values: []const []const u8,

    pub const json_field_names = .{
        .condition_key = "conditionKey",
        .condition_operator = "conditionOperator",
        .condition_values = "conditionValues",
    };
};
