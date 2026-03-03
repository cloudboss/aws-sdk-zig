const LeftExpression = @import("left_expression.zig").LeftExpression;
const OperatorType = @import("operator_type.zig").OperatorType;
const RightExpression = @import("right_expression.zig").RightExpression;

/// Filter expression for retrieving events based on metadata associated with an
/// event.
pub const EventMetadataFilterExpression = struct {
    /// Left operand of the event metadata filter expression.
    left: LeftExpression,

    /// Operator applied to the event metadata filter expression.
    operator: OperatorType,

    /// Right operand of the event metadata filter expression.
    right: ?RightExpression = null,

    pub const json_field_names = .{
        .left = "left",
        .operator = "operator",
        .right = "right",
    };
};
