const ArchiveBooleanToEvaluate = @import("archive_boolean_to_evaluate.zig").ArchiveBooleanToEvaluate;
const ArchiveBooleanOperator = @import("archive_boolean_operator.zig").ArchiveBooleanOperator;

/// A boolean expression to evaluate email attribute values.
pub const ArchiveBooleanExpression = struct {
    /// The email attribute value to evaluate.
    evaluate: ArchiveBooleanToEvaluate,

    /// The boolean operator to use for evaluation.
    operator: ArchiveBooleanOperator,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
    };
};
