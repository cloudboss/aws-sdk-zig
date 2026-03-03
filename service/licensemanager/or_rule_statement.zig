const MatchingRuleStatement = @import("matching_rule_statement.zig").MatchingRuleStatement;
const ScriptRuleStatement = @import("script_rule_statement.zig").ScriptRuleStatement;

/// OR rule statement.
pub const OrRuleStatement = struct {
    /// Matching rule statements.
    matching_rule_statements: ?[]const MatchingRuleStatement = null,

    /// Script rule statements.
    script_rule_statements: ?[]const ScriptRuleStatement = null,

    pub const json_field_names = .{
        .matching_rule_statements = "MatchingRuleStatements",
        .script_rule_statements = "ScriptRuleStatements",
    };
};
