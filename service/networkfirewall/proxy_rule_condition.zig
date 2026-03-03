/// Match criteria that specify what traffic attributes to examine.
pub const ProxyRuleCondition = struct {
    /// Defines what is to be matched.
    condition_key: ?[]const u8 = null,

    /// Defines how to perform a match.
    condition_operator: ?[]const u8 = null,

    /// Specifes the exact value that needs to be matched against.
    condition_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .condition_key = "ConditionKey",
        .condition_operator = "ConditionOperator",
        .condition_values = "ConditionValues",
    };
};
