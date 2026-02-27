const Analysis = @import("analysis.zig").Analysis;
const RuleVerdictAttribute = @import("rule_verdict_attribute.zig").RuleVerdictAttribute;

/// The verdict to evaluate in a verdict condition expression.
pub const RuleVerdictToEvaluate = union(enum) {
    /// The Add On ARN and its returned value to evaluate in a verdict condition
    /// expression.
    analysis: ?Analysis,
    /// The email verdict attribute to evaluate in a string verdict expression.
    attribute: ?RuleVerdictAttribute,

    pub const json_field_names = .{
        .analysis = "Analysis",
        .attribute = "Attribute",
    };
};
