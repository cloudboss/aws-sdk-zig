const Action = @import("action.zig").Action;

/// Describes a rule.
pub const TopicRule = struct {
    /// The actions associated with the rule.
    actions: ?[]const Action,

    /// The version of the SQL rules engine to use when evaluating the rule.
    aws_iot_sql_version: ?[]const u8,

    /// The date and time the rule was created.
    created_at: ?i64,

    /// The description of the rule.
    description: ?[]const u8,

    /// The action to perform when an error occurs.
    error_action: ?Action,

    /// Specifies whether the rule is disabled.
    rule_disabled: ?bool,

    /// The name of the rule.
    rule_name: ?[]const u8,

    /// The SQL statement used to query the topic. When using a SQL query with
    /// multiple
    /// lines, be sure to escape the newline characters.
    sql: ?[]const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .aws_iot_sql_version = "awsIotSqlVersion",
        .created_at = "createdAt",
        .description = "description",
        .error_action = "errorAction",
        .rule_disabled = "ruleDisabled",
        .rule_name = "ruleName",
        .sql = "sql",
    };
};
