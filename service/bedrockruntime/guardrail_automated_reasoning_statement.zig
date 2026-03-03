/// A logical statement that includes both formal logic representation and
/// natural language explanation.
pub const GuardrailAutomatedReasoningStatement = struct {
    /// The formal logical representation of the statement.
    logic: ?[]const u8 = null,

    /// The natural language explanation of the logical statement.
    natural_language: ?[]const u8 = null,

    pub const json_field_names = .{
        .logic = "logic",
        .natural_language = "naturalLanguage",
    };
};
