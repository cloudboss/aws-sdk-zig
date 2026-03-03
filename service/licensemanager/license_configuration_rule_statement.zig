const AndRuleStatement = @import("and_rule_statement.zig").AndRuleStatement;
const MatchingRuleStatement = @import("matching_rule_statement.zig").MatchingRuleStatement;
const OrRuleStatement = @import("or_rule_statement.zig").OrRuleStatement;

/// License configuration rule statement.
pub const LicenseConfigurationRuleStatement = struct {
    /// AND rule statement.
    and_rule_statement: ?AndRuleStatement = null,

    /// Matching rule statement.
    matching_rule_statement: ?MatchingRuleStatement = null,

    /// OR rule statement.
    or_rule_statement: ?OrRuleStatement = null,

    pub const json_field_names = .{
        .and_rule_statement = "AndRuleStatement",
        .matching_rule_statement = "MatchingRuleStatement",
        .or_rule_statement = "OrRuleStatement",
    };
};
