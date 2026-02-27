/// Represents a logical statement that can be expressed both in formal logic
/// notation and natural language, providing dual representations for better
/// understanding and validation.
pub const AutomatedReasoningLogicStatement = struct {
    /// The formal logic representation of the statement using mathematical notation
    /// and logical operators.
    logic: []const u8,

    /// The natural language representation of the logical statement, providing a
    /// human-readable interpretation of the formal logic.
    natural_language: ?[]const u8,

    pub const json_field_names = .{
        .logic = "logic",
        .natural_language = "naturalLanguage",
    };
};
