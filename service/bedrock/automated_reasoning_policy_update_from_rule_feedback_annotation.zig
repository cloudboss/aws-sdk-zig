/// An annotation for updating the policy based on feedback about how specific
/// rules performed during testing or real-world usage.
pub const AutomatedReasoningPolicyUpdateFromRuleFeedbackAnnotation = struct {
    /// The feedback information about rule performance, including suggestions for
    /// improvements or corrections.
    feedback: []const u8,

    /// The list of rule identifiers that the feedback applies to.
    rule_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .feedback = "feedback",
        .rule_ids = "ruleIds",
    };
};
