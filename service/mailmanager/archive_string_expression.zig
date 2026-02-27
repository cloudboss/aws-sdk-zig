const ArchiveStringToEvaluate = @import("archive_string_to_evaluate.zig").ArchiveStringToEvaluate;
const ArchiveStringOperator = @import("archive_string_operator.zig").ArchiveStringOperator;

/// A string expression to evaluate an email attribute value against one or more
/// string values.
pub const ArchiveStringExpression = struct {
    /// The attribute of the email to evaluate.
    evaluate: ArchiveStringToEvaluate,

    /// The operator to use when evaluating the string values.
    operator: ArchiveStringOperator,

    /// The list of string values to evaluate the email attribute against.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
