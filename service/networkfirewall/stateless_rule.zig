const RuleDefinition = @import("rule_definition.zig").RuleDefinition;

/// A single stateless rule. This is used in StatelessRulesAndCustomActions.
pub const StatelessRule = struct {
    /// Indicates the order in which to run this rule relative to all of the
    /// rules that are defined for a stateless rule group. Network Firewall
    /// evaluates the rules in a
    /// rule group starting with the lowest priority setting. You must ensure that
    /// the priority
    /// settings are unique for the rule group.
    ///
    /// Each stateless rule group uses exactly one `StatelessRulesAndCustomActions`
    /// object, and each `StatelessRulesAndCustomActions` contains exactly one
    /// `StatelessRules` object. To ensure unique priority settings for your rule
    /// groups, set unique priorities for the stateless rules that you define inside
    /// any single
    /// `StatelessRules` object.
    ///
    /// You can change the priority settings of your rules at any time. To make it
    /// easier to
    /// insert rules later, number them so there's a wide range in between, for
    /// example use 100,
    /// 200, and so on.
    priority: i32,

    /// Defines the stateless 5-tuple packet inspection criteria and the action to
    /// take on a
    /// packet that matches the criteria.
    rule_definition: RuleDefinition,

    pub const json_field_names = .{
        .priority = "Priority",
        .rule_definition = "RuleDefinition",
    };
};
