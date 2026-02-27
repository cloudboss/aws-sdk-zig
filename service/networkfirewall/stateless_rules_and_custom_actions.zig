const CustomAction = @import("custom_action.zig").CustomAction;
const StatelessRule = @import("stateless_rule.zig").StatelessRule;

/// Stateless inspection criteria. Each stateless rule group uses exactly one of
/// these data
/// types to define its stateless rules.
pub const StatelessRulesAndCustomActions = struct {
    /// Defines an array of individual custom action definitions that are available
    /// for use by
    /// the stateless rules in this `StatelessRulesAndCustomActions` specification.
    /// You
    /// name each custom action that you define, and then you can use it by name in
    /// your StatelessRule
    /// RuleDefinition
    /// `Actions` specification.
    custom_actions: ?[]const CustomAction,

    /// Defines the set of stateless rules for use in a stateless rule group.
    stateless_rules: []const StatelessRule,

    pub const json_field_names = .{
        .custom_actions = "CustomActions",
        .stateless_rules = "StatelessRules",
    };
};
