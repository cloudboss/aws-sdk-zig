/// Information about answer data for a contact evaluation. Answer data must be
/// either string, numeric, or not
/// applicable.
pub const EvaluationAnswerData = union(enum) {
    /// Date and time value provided as an answer to an evaluation question.
    date_time_value: ?[]const u8,
    /// The flag to mark the question as not applicable.
    not_applicable: ?bool,
    /// The numeric value for an answer in a contact evaluation.
    numeric_value: ?f64,
    /// The string value for an answer in a contact evaluation.
    string_value: ?[]const u8,
    /// String values provided as answers to evaluation questions.
    string_values: ?[]const []const u8,

    pub const json_field_names = .{
        .date_time_value = "DateTimeValue",
        .not_applicable = "NotApplicable",
        .numeric_value = "NumericValue",
        .string_value = "StringValue",
        .string_values = "StringValues",
    };
};
