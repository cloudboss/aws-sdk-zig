const Action = @import("action.zig").Action;

/// Describes a rule.
pub const TopicRulePayload = struct {
    /// The actions associated with the rule.
    actions: []const Action,

    /// The version of the SQL rules engine to use when evaluating the rule.
    aws_iot_sql_version: ?[]const u8,

    /// The description of the rule.
    description: ?[]const u8,

    /// The action to take when an error occurs.
    error_action: ?Action,

    /// Specifies whether the rule is disabled.
    rule_disabled: ?bool,

    /// The SQL statement used to query the topic. For more information, see [IoT
    /// SQL
    /// Reference](https://docs.aws.amazon.com/iot/latest/developerguide/iot-sql-reference.html) in the *IoT Developer Guide*.
    sql: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .aws_iot_sql_version = "awsIotSqlVersion",
        .description = "description",
        .error_action = "errorAction",
        .rule_disabled = "ruleDisabled",
        .sql = "sql",
    };
};
