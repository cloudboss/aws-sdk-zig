const LeftExpression = @import("left_expression.zig").LeftExpression;
const OperatorType = @import("operator_type.zig").OperatorType;
const RightExpression = @import("right_expression.zig").RightExpression;

/// Filters to apply to metadata associated with a memory. Specify the metadata
/// key and value in the `left` and `right` fields and use the `operator` field
/// to define the relationship to match.
pub const MemoryMetadataFilterExpression = struct {
    left: LeftExpression,

    /// The relationship between the metadata key and value to match when applying
    /// the metadata filter.
    operator: OperatorType,

    right: ?RightExpression,

    pub const json_field_names = .{
        .left = "left",
        .operator = "operator",
        .right = "right",
    };
};
