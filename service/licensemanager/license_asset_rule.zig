const RuleStatement = @import("rule_statement.zig").RuleStatement;

/// License asset rule.
pub const LicenseAssetRule = struct {
    /// Rule statement.
    rule_statement: RuleStatement,

    pub const json_field_names = .{
        .rule_statement = "RuleStatement",
    };
};
