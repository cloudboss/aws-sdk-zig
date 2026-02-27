/// Represents a set of rules that operate on completely separate variables,
/// indicating they address different concerns or domains within the policy.
pub const AutomatedReasoningPolicyDisjointRuleSet = struct {
    /// The list of rules that form this disjoint set, all operating on the same set
    /// of variables.
    rules: []const []const u8,

    /// The set of variables that are used by the rules in this disjoint set.
    variables: []const []const u8,

    pub const json_field_names = .{
        .rules = "rules",
        .variables = "variables",
    };
};
