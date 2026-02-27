/// An annotation for adding a new rule to the policy by converting a natural
/// language description into a formal logical expression.
pub const AutomatedReasoningPolicyAddRuleFromNaturalLanguageAnnotation = struct {
    /// The natural language description of the rule that should be converted into a
    /// formal logical expression.
    natural_language: []const u8,

    pub const json_field_names = .{
        .natural_language = "naturalLanguage",
    };
};
