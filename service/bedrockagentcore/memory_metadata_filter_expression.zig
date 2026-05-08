const MemoryRecordLeftExpression = @import("memory_record_left_expression.zig").MemoryRecordLeftExpression;
const MemoryRecordOperatorType = @import("memory_record_operator_type.zig").MemoryRecordOperatorType;
const MemoryRecordRightExpression = @import("memory_record_right_expression.zig").MemoryRecordRightExpression;

/// Filters to apply to metadata associated with a memory. Specify the metadata
/// key and value in the `left` and `right` fields and use the `operator` field
/// to define the relationship to match.
pub const MemoryMetadataFilterExpression = struct {
    /// The metadata key to evaluate.
    left: MemoryRecordLeftExpression,

    /// The relationship between the metadata key and value to match when applying
    /// the metadata filter.
    operator: MemoryRecordOperatorType,

    /// The value to compare against. Required for all operators except EXISTS and
    /// NOT_EXISTS.
    right: ?MemoryRecordRightExpression = null,

    pub const json_field_names = .{
        .left = "left",
        .operator = "operator",
        .right = "right",
    };
};
