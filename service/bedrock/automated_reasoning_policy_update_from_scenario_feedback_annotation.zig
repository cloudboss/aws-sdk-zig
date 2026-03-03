/// An annotation for updating the policy based on feedback about how it
/// performed on specific test scenarios.
pub const AutomatedReasoningPolicyUpdateFromScenarioFeedbackAnnotation = struct {
    /// The feedback information about scenario performance, including any issues or
    /// improvements identified.
    feedback: ?[]const u8 = null,

    /// The list of rule identifiers that were involved in the scenario being
    /// evaluated.
    rule_ids: ?[]const []const u8 = null,

    /// The logical expression that defines the test scenario that generated this
    /// feedback.
    scenario_expression: []const u8,

    pub const json_field_names = .{
        .feedback = "feedback",
        .rule_ids = "ruleIds",
        .scenario_expression = "scenarioExpression",
    };
};
