const Operator = @import("operator.zig").Operator;

/// The threshold for the calculated attribute.
pub const Threshold = struct {
    /// The operator of the threshold.
    operator: Operator,

    /// The value of the threshold.
    value: []const u8,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
