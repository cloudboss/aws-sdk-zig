const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;
const JoinOperandProperties = @import("join_operand_properties.zig").JoinOperandProperties;
const JoinOperationType = @import("join_operation_type.zig").JoinOperationType;

/// A transform operation that combines data from two sources based on specified
/// join conditions.
pub const JoinOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The left operand for the join operation.
    left_operand: TransformOperationSource,

    /// Properties that control how the left operand's columns are handled in the
    /// join result.
    left_operand_properties: ?JoinOperandProperties = null,

    /// The join condition that specifies how to match rows between the left and
    /// right operands.
    on_clause: []const u8,

    /// The right operand for the join operation.
    right_operand: TransformOperationSource,

    /// Properties that control how the right operand's columns are handled in the
    /// join result.
    right_operand_properties: ?JoinOperandProperties = null,

    /// The type of join to perform, such as `INNER`, `LEFT`, `RIGHT`, or `OUTER`.
    @"type": JoinOperationType,

    pub const json_field_names = .{
        .alias = "Alias",
        .left_operand = "LeftOperand",
        .left_operand_properties = "LeftOperandProperties",
        .on_clause = "OnClause",
        .right_operand = "RightOperand",
        .right_operand_properties = "RightOperandProperties",
        .@"type" = "Type",
    };
};
