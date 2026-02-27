/// Provides an expression that evaluates to true or false.
pub const Condition = struct {
    /// The expression string that is evaluated.
    expression_string: []const u8,

    pub const json_field_names = .{
        .expression_string = "expressionString",
    };
};
