/// The status of a managed Contributor Insights rule.
pub const ManagedRuleState = struct {
    /// The name of the Contributor Insights rule that contains data for the
    /// specified
    /// Amazon Web Services resource.
    rule_name: []const u8,

    /// Indicates whether the rule is enabled or disabled.
    state: []const u8,

    pub const json_field_names = .{
        .rule_name = "RuleName",
        .state = "State",
    };
};
