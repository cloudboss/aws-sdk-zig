const Expression = @import("expression.zig").Expression;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The value of an `Expression` and its current status.
pub const ExpressionStatus = struct {
    /// The expression that is evaluated for sorting while processing a search
    /// request.
    options: Expression,

    status: OptionStatus,
};
