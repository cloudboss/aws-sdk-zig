/// Returns information about the approval rules applied to a pull request and
/// whether conditions have been met.
pub const Evaluation = struct {
    /// The names of the approval rules that have not had their conditions met.
    approval_rules_not_satisfied: ?[]const []const u8,

    /// The names of the approval rules that have had their conditions met.
    approval_rules_satisfied: ?[]const []const u8,

    /// Whether the state of the pull request is approved.
    approved: bool = false,

    /// Whether the approval rule requirements for the pull request have been
    /// overridden and no longer need to be met.
    overridden: bool = false,

    pub const json_field_names = .{
        .approval_rules_not_satisfied = "approvalRulesNotSatisfied",
        .approval_rules_satisfied = "approvalRulesSatisfied",
        .approved = "approved",
        .overridden = "overridden",
    };
};
